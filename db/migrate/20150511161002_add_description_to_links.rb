class AddDescriptionToLinks < ActiveRecord::Migration
  def change
    add_column :links, :description, :text, null: false, default: ''
  end
end
