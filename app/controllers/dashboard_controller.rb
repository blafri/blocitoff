class DashboardController < ApplicationController
  before_action :authenticate_user!
  
  def index
    # If user has not picked a time zone alert him
    # That he should
    if current_user.time_zone == nil
      flash.now[:alert] = "You have not configured a time zone. Please go to account settings and update your profile."
    end
  end
end
