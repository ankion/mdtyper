class Blog < ActiveRecord::Base
  belongs_to :user
  has_many :posts

  def to_param
    subdomain
  end
end
