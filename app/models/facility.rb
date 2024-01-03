class Facility < ApplicationRecord
  before_validation :set_prefecture

  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :onsen

  belongs_to_active_hash :facility_type
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user

  validates :facility_name, presence: true, uniqueness: { message: "の値が重複しているため、登録できません" }
  validates :facility_name_kana, presence: true
  validates :pref, presence: true
  validates :address, presence: true
  validates :facility_link, presence: true
  validates :facility_description, presence: true

  def set_prefecture
    self.pref = Prefecture.find_by(id: pref).name
  end

  def set_facility_type
    self.facility_type = FacilityType.find_by(id: facility_type).name
  end
end
