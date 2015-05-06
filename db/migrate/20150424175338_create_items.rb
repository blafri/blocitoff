class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.references :user, index: true, foreign_key: true
      t.datetime :expires_at, null: false

      t.timestamps null: false
    end
  end
end
