class Post < ActiveRecord::Base
  belongs_to :blog
  has_many :post_categoryships, :dependent => :destroy
  has_many :categories, :through => :post_categoryships
  accepts_nested_attributes_for :categories
  after_initialize :assign_values

  def assign_values
    self.publish_date ||= Time.now
  end
end
