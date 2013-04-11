class CreateCheckins < ActiveRecord::Migration
  def change
    create_table :checkins do |t|
      t.integer :employee_id
      t.boolean :is_coming
      t.string :message

      t.timestamps
    end
  end
end
