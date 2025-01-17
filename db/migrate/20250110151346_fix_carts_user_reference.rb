class FixCartsUserReference < ActiveRecord::Migration[8.0]
  def change
    if column_exists?(:carts, :user_id_id)
      remove_column :carts, :user_id_id
    end

    if column_exists?(:carts, :user_id)
      remove_column :carts, :user_id
    end

    unless column_exists?(:carts, :user)
      add_reference :carts, :user, null: false, foreign_key: true
    end
  end
end