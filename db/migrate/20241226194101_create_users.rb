class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.string :firsName
      t.string :lastName
      t.string :address
      t.string :phone

      t.timestamps
    end
  end
end
