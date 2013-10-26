class Category < ActiveRecord::Base
  include Sluggable
  has_many :categorizations, dependent: :destroy
  has_many :posts, :through => :categorizations

  validates :name, presence: true

  sluggable_column :name
end