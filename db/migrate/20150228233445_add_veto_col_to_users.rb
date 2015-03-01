class AddVetoColToUsers < ActiveRecord::Migration
  def change
    add_column :users, :veto, :boolean, default: false  
  end
end
