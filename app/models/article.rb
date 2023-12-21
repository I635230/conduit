class Article < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true

  EXCLUDE_SYMBOL_REGEX = /\A[^!\#$'()*+,\/:;=?@\[\]]+\z/
  validates :title, presence: true, format: { with: EXCLUDE_SYMBOL_REGEX }
  validates :slug, presence: true, uniqueness: true, format: { with: EXCLUDE_SYMBOL_REGEX }
end
