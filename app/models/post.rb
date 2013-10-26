class Post < ActiveRecord::Base
  include Voteable
  include Sluggable
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :categorizations, dependent: :destroy
  has_many :categories, :through => :categorizations
  has_many :votes, as: :voteable, dependent: :destroy

  validates :title, presence: true
  validates :url, presence: true

  sluggable_column :title
end