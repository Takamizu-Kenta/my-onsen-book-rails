class Api::V1::FacilitiesController < ApplicationController
  def index
    @facilities = Facility.all
  end

  def show
    @facility = Facility.find(params[:id])
    @related_onsen = @facility.onsen

    puts @facility.onsen_id
    puts @related_onsen.onsen_name
  end

  def create
    if params[:facility][:facility_image].present?
      uploaded_file = params[:facility][:facility_image]
      cloudinary_response = upload_image_to_cloudinary(uploaded_file)
      params[:facility][:facility_image] = cloudinary_response
    end

    @facility = Facility.new(facility_params)

    if @facility.save
      render json: @facility, status: :created
    else
      render json: @facility.errors, status: :unprocessable_entity
    end
  end

  def update
    if @facility.update(facility_params)
      render json: @facility
    else
      render json: @facility.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @facility.destroy
    head :no_content
  end

  private

  def upload_image_to_cloudinary(image)
    res = Cloudinary::Uploader.upload(
      image.tempfile.path,
      folder: 'facility_images'
    )
    res['secure_url']
  end

  def facility_params
    params.require(:facility)
      .permit(
        :onsen_id,
        :facility_type_id,
        :facility_name,
        :facility_name_kana,
        :facility_type,
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
