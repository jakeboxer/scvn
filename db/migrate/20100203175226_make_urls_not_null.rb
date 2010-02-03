class MakeUrlsNotNull < ActiveRecord::Migration
  def self.up
    change_column :addresses, :url, :text, :null => false, :default => ''
  end

  def self.down
    change_column :addresses, :url, :text, :null => true, :default => nil
  end
end
