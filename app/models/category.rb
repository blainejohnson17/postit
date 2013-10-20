class Category < ActiveRecord::Base
  has_many :categorizations, dependent: :destroy
  has_many :posts, :through => :categorizations

  validates :name, presence: true
end