class Api::V1::FacilityRegistrationsController < ApplicationController
  def create
    on_conflict = false

    ActiveRecord::Base.transaction do
      onsen = Onsen.find_or_initialize_by(str_key: onsen_params[:str_key])
      facility = Facility.find_or_initialize_by(facility_name: facility_params[:facility_name])

      if onsen.persisted? || facility.persisted?
        on_conflict = true
      else
        onsen.assign_attributes(onsen_params)
        onsen.save!

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

  def onsen_params
    params.require(:onsen)
      .permit(:str_key, :pref, :onsen_name, :onsen_name_kana, :quality, :effects, :onsen_link, :onsen_description)
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
        :facility_description
      )
  end
end
