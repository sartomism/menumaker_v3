class AddPersonasToPlatobloque < ActiveRecord::Migration
  def self.up
    add_column :platobloques, :personas, :integer
  end

  def self.down
    remove_column :platobloques, :personas
  end
end
