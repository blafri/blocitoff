Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, timeout: 600)
end
Capybara.javascript_driver = :poltergeist