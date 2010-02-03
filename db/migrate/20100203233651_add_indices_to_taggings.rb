class AddIndicesToTaggings < ActiveRecord::Migration
  def self.up
    add_index :taggings, [:address_id, :tag_id],
      :unique => true, :name => 'address_tag_index'
  end

  def self.down
    remove_index :taggings, 'address_tag_index'
  end
end
