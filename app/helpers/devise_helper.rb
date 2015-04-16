module DeviseHelper
  def devise_signup_error!
    flash.now[:error] = "There was an error signing up!"
  end
  
  def devise_error_messages!
    return "" if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join

    html = <<-START
<div class='alert alert-danger text-center'>
        <ul class='list-unstyled'>
          #{messages}
        </ul>
      </div>
    START

    html.html_safe
  end

  def devise_error_messages?
    resource.errors.empty? ? false : true
  end

end