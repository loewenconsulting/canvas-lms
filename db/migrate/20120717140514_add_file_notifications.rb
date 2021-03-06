class AddFileNotifications < ActiveRecord::Migration
  tag :predeploy

  def self.up
    # (shard check added later; dupes removed in AddUniqueIndexOnNotifications)
    return unless Shard.current.default?
    Notification.create!(:name => "New File Added", :category => "Files")
    Notification.create!(:name => "New Files Added", :category => "Files")
  end

  def self.down
    # (try on each shard, because there may be duplicates due to the above)
    Notification.find_by_name("New File Added").try(:destroy)
    Notification.find_by_name("New Files Added").try(:destroy)
  end
end
