class ChangeBlogSubdomainToUnique < ActiveRecord::Migration
  def change
    add_index :blogs, :subdomain, :unique => true
  end
end
