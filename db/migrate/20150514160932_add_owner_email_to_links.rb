class AddOwnerEmailToLinks < ActiveRecord::Migration
  def change
    remove_column :links, :owner_id
    remove_column :links, :owner_type

    add_column :links, :owner_email, :string, default: '', null: false
    add_index :links, :owner_email
  end
end
