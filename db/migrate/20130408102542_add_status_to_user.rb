class AddStatusToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :status, :string
    add_column :users, :accounttype, :string
  end

  def self.down
    remove_column :users, :accounttype
    remove_column :users, :status
  end
end
