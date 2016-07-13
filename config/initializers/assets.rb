Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.precompile += %w(application.css.scss bootstrap.css)
Rails.application.config.assets.precompile += %w( ckeditor/* )