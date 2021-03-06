# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w(
  ckeditor/* 

  landing_page.css 
  landing_page.js

  devise.css 
  devise.js
   
  publications.css 
  publications.js

  diary.css 
  diary.js

  objectives.css 
  objectives.js

  user_profile.css 
  user_profile.js

  news_feed.css 
  news_feed.js

  admin.css 
  admin.js
)
