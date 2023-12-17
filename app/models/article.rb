class Article < ApplicationRecord
  belongs_to :user
  before_save { slug.downcase! }
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true
  validates :title, presence: true
  validates :slug, presence: true, uniqueness: true
end
