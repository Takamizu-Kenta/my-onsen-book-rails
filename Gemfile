source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.3"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.8"

# 日本語設定
gem 'rails-i18n'

# Use mysql as the database for Active Record
gem "mysql2", "~> 0.5"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# draw json in view
gem 'jb'

# Use '.env'
gem 'dotenv-rails'

# DB migration
gem 'ridgepole'

# CORS対応
gem 'rack-cors'

# Active Hash
gem 'active_hash'
gem 'active_yaml'

# ひらがな→ローマ字変換
gem 'miyabi'

# 画像アップロード
gem 'carrierwave'
gem 'cloudinary'

# ログイン認証
gem "devise"
gem "devise-i18n"
gem "devise_token_auth"

# シリアライズ
gem "active_model_serializers"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "byebug", platforms: %i[mri mingw x64_mingw]

  # Call 'binding.pry'
  gem "pry-byebug"
  gem "pry-rails"

  # lint
  gem 'rubocop', require: false
  gem "rubocop-performance", require: false

  gem "rubocop-rails", require: false
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"

  # annotation
  gem "annotate"

  gem 'letter_opener_web'

  gem 'better_errors'
  gem 'binding_of_caller'
end
