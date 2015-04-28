module UsersHelper
  def options_for_timezone
    TimeZone.all.map do |zone|
      [zone.description, zone.id]
    end
  end
  
  def options_for_email_reminder_days
    [[1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7]]
  end
end