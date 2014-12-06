class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.text :description
      t.text :address
      t.string :email
      t.string :phone

      t.timestamps
    end
  end
end
