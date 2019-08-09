class Post < ApplicationRecord
  has_many :tag_posts, dependent: :destroy
  has_many :tags, through: :tag_posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  belongs_to :user
  belongs_to :category

  scope :newest, ->{order created_at: :desc}

  validates :title, presence: true, length: {minimum: 10}
  validates :content, presence: true, length: {minimum: 10}

  delegate :full_name, :user_name, :avatar, :log_out_at, to: :user, prefix: true
  delegate :name, to: :category, prefix: true
end
