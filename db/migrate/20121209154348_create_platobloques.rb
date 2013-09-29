class CreatePlatobloques < ActiveRecord::Migration
  def self.up
    create_table :platobloques do |t|
      t.integer :bloque

      t.timestamps
    end
  end

  def self.down
    drop_table :platobloques
  end
end
