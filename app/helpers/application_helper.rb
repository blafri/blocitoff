module ApplicationHelper
  def page_controller_class
    controller = controller_name
    action = action_name
    "controller-#{controller} controller-#{controller}-view-#{action}"
  end
  
  def form_group_tag(errors, &block)
    if errors.any?
      content_tag(:div, capture(&block) + content_tag(:span, '', class: 'glyphicon glyphicon-remove form-control-feedback'), class: 'form-group has-error has-feedback')
    else
      content_tag :div, capture(&block), class: 'form-group'
    end
  end
end
