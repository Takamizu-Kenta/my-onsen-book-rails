class Api::V1::FacilityRegistrationsController < ApplicationController
  def create
    on_conflict = false

    ActiveRecord::Base.transaction do
      onsen = Onsen.find_or_initialize_by(str_key: onsen_params[:str_key])
      facility = Facility.find_or_initialize_by(facility_name: facility_params[:facility_name])

      if onsen.persisted? || facility.persisted?
        on_conflict = true
      else
        if params[:onsen][:onsen_image].present?
          uploaded_file = params[:onsen][:onsen_image]
          cloudinary_response = upload_image_to_cloudinary(uploaded_file)
          params[:onsen][:onsen_image] = cloudinary_response
        end

        onsen.assign_attributes(onsen_params)

        onsen.save!

        if ActiveRecord::Type::Boolean.new.cast(params[:onsen][:add_my_onsen_book])
          my_onsen = current_api_v1_user.my_onsens.find_or_initialize_by(onsen_id: onsen.id)
          my_onsen.save!
        end

        if params[:facility][:facility_image].present?
          uploaded_file = params[:facility][:facility_image]
          cloudinary_response = upload_image_to_cloudinary(uploaded_file)
          params[:facility][:facility_image] = cloudinary_response
        end
        facility.assign_attributes(facility_params.merge(onsen_id: onsen.id))
        facility.save!
      end
    end

    if on_conflict
      render status: :conflict, json: { status: 409, message: "温泉または施設が既に存在しています。" }
      return
    end

    head :ok
  rescue => e
    render json: { message: e.message, status: 422 }, status: :unprocessable_entity
  end

  private

  def upload_image_to_cloudinary(image)
    res = Cloudinary::Uploader.upload(
      image.tempfile.path,
      if params[:onsen][:onsen_image].present?
        { folder: 'onsen_images' }
      else
        { folder: 'facility_images' }
      end
    )
    res['secure_url']
  end

  def onsen_params
    params.require(:onsen)
      .permit(
        :str_key,
        :pref,
        :onsen_name,
        :onsen_name_kana,
        :quality,
        :effects,
        :onsen_link,
        :onsen_image,
        :onsen_description
      )
  end

  def facility_params
    params.require(:facility)
      .permit(
        :facility_type_id,
        :facility_name,
        :facility_name_kana,
        :post_code,
        :pref,
        :city,
        :address,
        :facility_link,
        :facility_image,
        :facility_description
      )
  end
end
