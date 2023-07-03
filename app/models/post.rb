class Post < ApplicationRecord
  validates :title, presence: true,
                   uniqueness: true
  validates :content, presence: true,
                   length: { minimum: 5 }
end
