class Prefecture < ActiveYaml::Base
  include ActiveHash::Enum
  include ActiveHash::Associations

  set_root_path "config/active_hash"
  set_filename "prefecture"

  # rubocop:disable Rails/HasManyOrHasOneDependent
  has_many :onsens, dependent: :destroy
  has_many :facilities, through: :onsens
  # rubocop:enable Rails/HasManyOrHasOneDependent
end
