Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.action_controller.perform_caching = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.seconds.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  config.default_url_options = { host: 'localhost', port: 3000 }
  # Don't care if the mailer can't send.
  # config.action_mailer.raise_delivery_errors = false
  # config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # config.active_record.verbose_query_logs = true

  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

  config.action_mailer.delivery_method = :sendmail

  config.action_mailer.perform_caching = false

  config.action_mailer.perform_deliveries = false

  config.action_mailer.raise_delivery_errors = true

  config.action_mailer.smtp_settings = {
      address: 'smtp.gmail.com',
      port: 587,
      domain: 'example.com',
      user_name: Rails.application.credentials.aws[:main_mailer_email],
      password: Rails.application.credentials.aws[:main_mailer_pass],
      openssl_verify_mode: 'none',
      authentication: 'plain',
      enable_starttls_auto: true
  }

  # Raise an error on page load if there are pending migrations.
  # config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  ENV['AWS_ACCESS_KEY_ID'] = Rails.application.credentials.aws[:aws_akid]
  ENV['AWS_SECRET_ACCESS_KEY'] = Rails.application.credentials.aws[:aws_sak]
  ENV['AWS_REGION'] = 'eu-central-1'
end
