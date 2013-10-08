class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :categorizations
  has_many :categories, :through => :categorizations

  validates :title, presence: true
  validates :url, presence: true
end