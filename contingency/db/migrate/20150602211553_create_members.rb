class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.attachment :avatar
      t.text :biography
      t.string :handle
      t.string :email
      t.string :password_digest
      t.string :rank
      t.string :role

      t.timestamps null: false
    end
    add_index :members, :handle, unique: true
  end
end
