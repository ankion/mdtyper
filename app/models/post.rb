class Post < ActiveRecord::Base
  belongs_to :blog
  after_initialize :assign_values

  def assign_values
    self.publish_date ||= Time.now
  end
end
