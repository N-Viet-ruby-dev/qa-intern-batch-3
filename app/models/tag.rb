class Tag < ApplicationRecord
  has_many :tag_posts, dependent: :destroy
  has_many :posts, through: :tag_posts

  validates :name, length: { in: 3..10 }
end
