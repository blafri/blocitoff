class AddTimeZoneToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :time_zone, index: true, foreign_key: true
  end
end
