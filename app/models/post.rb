class Post < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_many :categorizations
  has_many :categories, :through => :categorizations
  has_many :votes, as: :voteable

  validates :title, presence: true
  validates :url, presence: true
end