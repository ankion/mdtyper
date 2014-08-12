class Blog < ActiveRecord::Base
  belongs_to :user
  has_many :posts
  validates_presence_of :subdomain, :title
  validates_uniqueness_of :subdomain
  validates_format_of :subdomain, :with => /\A[a-z][a-z0-9]{2,17}\z/i
  validates_exclusion_of :subdomain, :in => [
    "www",
    "api",
    "help",
    "mail"
  ]

  def to_param
    subdomain
  end
end
