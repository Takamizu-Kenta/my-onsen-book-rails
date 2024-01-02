class FacilityType < ActiveYaml::Base
  include ActiveHash::Enum
  include ActiveHash::Associations

  set_root_path "config/active_hash"
  set_filename "facility_type"

  # rubocop:disable all
  has_many :facilities
  # rubocop:enable all
end
