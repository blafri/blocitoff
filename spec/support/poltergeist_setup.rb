Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, timeout: 30)
end
Capybara.javascript_driver = :poltergeist