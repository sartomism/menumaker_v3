class CreateMenulayouts < ActiveRecord::Migration
  def self.up
    create_table :menulayouts do |t|
      t.string :nombre
      t.integer :usuario

      t.timestamps
    end
  end

  def self.down
    drop_table :menulayouts
  end
end
