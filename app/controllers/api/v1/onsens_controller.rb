class Api::V1::OnsensController < ApplicationController
  def index
    @onsens = Onsen.order("RAND()").limit(8)
    render json: @onsens
  end

  def all
    @onsens = Onsen.all
    render json: @onsens
  end

  def show
    @onsen = Onsen.find(params[:id])
    render json: @onsen
  end

  def create
    @onsen = Onsen.new(onsen_params)

    if @onsen.save
      render json: @onsen, status: :created
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

  private

  def onsen_params
    params.require(:onsen).permit(:str_key, :pref, :onsen_name, :onsen_name_kana, :quality, :effects, :onsen_link ,:description)
  end
end
