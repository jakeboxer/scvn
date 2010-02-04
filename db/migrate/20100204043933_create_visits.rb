class CreateVisits < ActiveRecord::Migration
  def self.up
    create_table :visits do |t|
      t.integer :address_id, :null => :false, :default => 0

      t.timestamps
    end
    
    add_index :visits, :address_id
  end

  def self.down
    drop_table :visits
  end
end
