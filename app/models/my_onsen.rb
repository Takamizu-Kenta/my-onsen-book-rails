class MyOnsen < ApplicationRecord
  belongs_to :user
  belongs_to :onsen
  validates :user_id, uniqueness: { scope: :onsen_id }
end
