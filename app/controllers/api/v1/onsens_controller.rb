class Api::V1::OnsensController < ApplicationController
  def index
    @onsens = Onsen.order("RAND()").limit(6)
    render json: @onsens
  end

  def create
    @onsen = Onsen.new(onsen_params)

    if @onsen.save
      render json: @onsen, status: :created, location: @onsen
    else
      render json: @onsen.errors, status: :unprocessable_entity
    end
  end

  def update
    if @onsen.update(onsen_params)
      render json: @onsen
    else
      render json: @onsen.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @onsen.destroy
    head :no_content
  end
end
