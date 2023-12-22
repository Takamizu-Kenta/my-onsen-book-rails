class Api::V1::FacilitiesController < ApplicationController
  def index
    @facilities = Facility.order("RAND()").limit(8)
    render json: @facilities
  end

  def all
    @facilities = Facility.all
    render json: @facilities
  end

  def show
    @facility = Facility.find(params[:id])
    render json: @facility
  end

  def create
    @facility = Facility.new(facility_params)

    if @facility.save
      render json: @facility, status: :created, location: @facility
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
end
