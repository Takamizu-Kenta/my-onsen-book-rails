class Api::V1::BaseController < ApplicationController
  # rubocop :disable Style/Alias
  alias_method :current_user, :current_api_v1_user
  alias_method :authenticate_user!, :authenticate_api_v1_user!
  alias_method :user_signed_in?, :api_v1_user_signed_in?
  # rubocop :enable Style/Alias
end
