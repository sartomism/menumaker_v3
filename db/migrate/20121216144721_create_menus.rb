class CreateMenus < ActiveRecord::Migration
  def self.up
    create_table :menus do |t|
      t.integer :usuario
      t.string :nombre

      t.timestamps
    end
  end

  def self.down
    drop_table :menus
  end
end
