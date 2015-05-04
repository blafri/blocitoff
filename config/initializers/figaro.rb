# These enviromen varibales are needed and will throw an error if they are
# not present

Figaro.require_keys("SENDGRID_USERNAME", "SENDGRID_PASSWORD", "DEVISE_SECRET", "SECRET_KEY_BASE")