class CreateTimeZones < ActiveRecord::Migration
  def change
    create_table :time_zones do |t|
      t.string :name
      t.string :description
      t.integer :utc_offset

      t.timestamps null: false
    end
  end
end
