class CreateTaggings < ActiveRecord::Migration
  def self.up
    create_table :taggings do |t|
      t.integer :address_id, :null => false, :default => 0
      t.integer :tag_id,     :null => false, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :taggings
  end
end
