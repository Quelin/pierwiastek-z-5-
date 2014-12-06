class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.boolean :done
      t.datetime :start_time
      t.datetime :end_time
      t.integer :project_id
      t.integer :user_id
      t.integer :milestone_id

      t.timestamps
    end
  end
end
