# frozen_string_literal: true

# セッションが保持できないためActiveRecord::Baseを使用
class User < ActiveRecord::Base # rubocop:disable Rails/ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  include DeviseTokenAuth::Concerns::User
end
