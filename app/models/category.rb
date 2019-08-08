class Category < ApplicationRecord
  has_many :posts, dependent: :delete_all

  validates :name, presence: true, uniqueness: {case_sensitive: false}
  validates :description, presence: true
  scope :newest, ->{order created_at: :desc}
end
