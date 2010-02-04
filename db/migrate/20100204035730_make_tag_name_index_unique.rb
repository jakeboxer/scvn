class MakeTagNameIndexUnique < ActiveRecord::Migration
  def self.up
    remove_index :tags, :name # Get rid of the old tagname index
    add_index :tags, :name, # Add a new unique one
      :unique => true, :name => 'tag_name_unique_index'
  end

  def self.down
    remove_index :tags, :name => 'tag_name_unique_index'
    add_index :tags, :name # Add back the old one
  end
end
