if Rails.env.development? || Rails.env.production?
  Rack::Timeout.timeout = 25  # seconds
end