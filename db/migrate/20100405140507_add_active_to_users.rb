class AddActiveToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :active_since, :datetime, :default => nil
  end

  def self.down
    remove_column :users, :active_since
  end
end
