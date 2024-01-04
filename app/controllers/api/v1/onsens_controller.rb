class Api::V1::OnsensController < ApplicationController
  def index
    @onsens = Onsen.order("RAND()").limit(8)
  end

  def all
    @onsens = Onsen.all
  end

  def show
    @onsen = Onsen.find(params[:id])
  end

  def create
    if params[:onsen][:onsen_image].present?
      uploaded_file = params[:onsen][:onsen_image]
      cloudinary_response = upload_image_to_cloudinary(uploaded_file)
      params[:onsen][:onsen_image] = cloudinary_response
    end

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

  def upload_image_to_cloudinary(image)
    res = Cloudinary::Uploader.upload(
      image.tempfile.path,
      folder: 'onsen_images'
    )
    res['secure_url']
  end

  def onsen_params
    params.require(:onsen)
      .permit(:str_key, :pref, :onsen_name, :onsen_name_kana, :quality, :effects, :onsen_link, :onsen_image, :onsen_description)
  end
end
