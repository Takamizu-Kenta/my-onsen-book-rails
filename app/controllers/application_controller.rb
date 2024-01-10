class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  include DeviseTokenAuth::Concerns::SetUserByToken
  include DeviseHackFakeSession
  include ActionController::Cookies
end
