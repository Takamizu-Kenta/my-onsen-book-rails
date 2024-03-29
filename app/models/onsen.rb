class Onsen < ApplicationRecord
  before_validation :set_str_key, :set_prefecture

  extend ActiveHash::Associations::ActiveRecordExtensions

  has_many :facilities, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :my_onsens, dependent: :destroy
  has_many :owner_users, through: :my_onsens, source: :user

  belongs_to_active_hash :prefecture

  validates :str_key, presence: true, uniqueness: { case_sensitive: false }
  validates :onsen_image, presence: true

  def set_str_key
    self.str_key = onsen_name_kana.to_roman.gsub("onsen", "")
  end

  def set_prefecture
    self.pref = Prefecture.find_by(id: pref)&.name
  end

  def is_owner(user)
    return my_onsens.exists?(user_id: user.id)
  end

  scope :by_name, lambda { |name|
    where("onsen_name LIKE ?", "%#{name}%") if name.present?
  }

  scope :by_prefecture_id, lambda { |prefecture_id|
    where(pref: Prefecture.find_by(id: prefecture_id)&.name) if prefecture_id.present?
  }
end
