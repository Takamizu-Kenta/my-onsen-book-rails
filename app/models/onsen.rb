class Onsen < ApplicationRecord
  before_validation :set_str_key, :set_prefecture

  extend ActiveHash::Associations::ActiveRecordExtensions

  has_many :facilities, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user

  belongs_to_active_hash :prefecture

  validates :str_key, presence: true, uniqueness: { case_sensitive: false }

  def set_str_key
    self.str_key = onsen_name_kana.to_roman.gsub("onsen", "")
  end

  def set_prefecture
    self.pref = Prefecture.find_by(id: pref).name
  end
end
