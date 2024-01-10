class Api::V1::OnsensController < ApplicationController
  before_action :authenticate_api_v1_user!, only: [:toggle_my_onsen, :my_onsen_book]

  def index
    @onsens = Onsen.includes(:my_onsens).order("RAND()").limit(8)
  end

  def all
    @onsens = Onsen.includes(:my_onsens)
      .by_name(params[:body][:name])
      .by_prefecture_id(params[:body][:prefecture_id])
      .all
  end

  def show
    @current_user = current_api_v1_user
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
      if ActiveRecord::Type::Boolean.new.cast(params[:onsen][:add_my_onsen_book])
        my_onsen = current_api_v1_user.my_onsens.find_or_initialize_by(onsen_id: @onsen.id)
        my_onsen.save!
      end

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

  def toggle_my_onsen
    onsen = Onsen.find(params[:id])
    my_onsen = current_api_v1_user.my_onsens.find_or_initialize_by(onsen_id: onsen.id)

    if my_onsen.persisted?
      my_onsen.destroy!
      return render json: { is_owner: false }, status: :ok
    else
      my_onsen.save!
      return render json: { is_owner: true }, status: :created
    end
  rescue => e
    render json: { message: e.message, status: 422 }, status: :unprocessable_entity
  end

  def my_onsen_book
    @onsens = current_api_v1_user.my_onsen_books.by_name(params[:body][:name])
      .by_prefecture_id(params[:body][:prefecture_id])
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
end
