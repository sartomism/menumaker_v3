class CreatePlatos < ActiveRecord::Migration
  def self.up
    create_table :platos do |t|
      t.integer :usuario
      t.string :nombre

      t.timestamps
    end
  end

  def self.down
    drop_table :platos
  end
end
