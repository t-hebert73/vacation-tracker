class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :company
      t.date :start_date
      t.float :vacation_days, :default => 0
      t.float :vacation_amount, :default => 0
      t.float :vacation_days_used, :default => 0
      t.float :vacation_amount_used, :default => 0
      t.float :hourly_wage
      t.integer :user_id, :null => false

      t.timestamps null: false
    end
    add_foreign_key :jobs, :users, column: :user_id
  end
end
