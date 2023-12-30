class Prefecture < ActiveYaml::Base
  include ActiveHash::Enum
  include ActiveHash::Associations

  set_root_path "config/active_hash"
  set_filename "prefecture"

  has_many :onsens
  has_many :facilities, through: :onsens
end
