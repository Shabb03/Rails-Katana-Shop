class CreateCarts < ActiveRecord::Migration[8.0]
  def change
    create_table :carts do |t|
      t.references :user_id, null: false, foreign_key: true
      t.boolean :is_active

      t.timestamps
    end
  end
end