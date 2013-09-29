class CreateBloquecomidas < ActiveRecord::Migration
  def self.up
    create_table :bloquecomidas do |t|
      t.string :nombre
      t.integer :orden

      t.timestamps
    end
  end

  def self.down
    drop_table :bloquecomidas
  end
end
