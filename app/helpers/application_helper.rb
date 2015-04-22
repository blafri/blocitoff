module ApplicationHelper
  def display_form_errors!(resource)
    return "" if resource.errors.empty?
    
    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    
    html = <<-START
<div class='alert alert-danger'>
  <ul class='list-unstyled'>
    #{messages}
  </ul>
</div>
START
    
    html.html_safe
  end
  
  def page_controller_class
    controller = controller_name
    action = action_name
    "controller-#{controller} controller-#{controller}-view-#{action}"
  end
  
  def form_group_tag(errors, glyphicon = true, &block)
    if !errors.any?
      return content_tag :div, capture(&block), class: 'form-group'
    end
      
    if glyphicon
      extra_html = content_tag(:span, '', class: 'glyphicon glyphicon-remove form-control-feedback')
    else
      extra_html = ''
    end
    
    content_tag(:div, capture(&block) + extra_html, class: 'form-group has-error has-feedback')
  end
  
  def is_link_active(link_path)
    if current_page?(link_path)
      return 'active'
    else
      return ''
    end
  end
  
  # This method makes it east to create a link for that contains bootstrap glyphicons
  # link_to_with_icon arguments:
  # Path -> (required) A link that will be used as the href for the a tag
  # link_to_options -> (optional) A hash of options to pass o link_to method
  # icon_options -> (required) A hash with the option to create the text and the icons see below
  #
  # icon Options parameters
  # :text -> (optional) The text to place after the icon
  # :icon_name -> (required) The name of the bootstap glyphicon you want to use
  # :tag_class -> (optional) Extra classes you want to add the the span that the glyphicon will use
  def link_to_with_icon(href_path, link_to_options = {}, icon_options)
    html_class = "glyphicon glyphicon-#{icon_options[:icon_name]}"
    
    if icon_options.has_key?(:tag_class)
      html_class += " #{icon_options[:tag_class]}"
    end
    
    # If text is present add a space to the begining of the text for 
    # Spacing to come out correctly else make text empty
    if icon_options.has_key?(:text)
      icon_options[:text].insert(0, ' ')
    else
      icon_options[:text] = ''
    end

    link_to(href_path, link_to_options) do
      concat content_tag(:span, '', class: html_class, aria: {hidden: "true"})
      concat icon_options[:text]
    end
  end
end
