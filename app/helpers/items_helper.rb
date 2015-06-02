module ItemsHelper
  def time_left_in_words(item)
    case item.days_left
    when 0
      'Today'
    when 7
      '1 Week'
    else
      item.days_left.to_s + ' Days'
    end
  end
end