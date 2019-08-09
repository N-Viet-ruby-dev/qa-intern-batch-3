class Comment < ApplicationRecord
  has_many :likes, dependent: :destroy
  belongs_to :user
  belongs_to :post

  scope :newest, ->{order created_at: :desc}

  validates :content, presence: true, length: {minimum: 17}

  delegate :avatar, to: :user, prefix: true
end
