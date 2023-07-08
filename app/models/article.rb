class Article < ApplicationRecord
  validates :name, presence: true,
                   uniqueness: true
  validates :body, presence: true,
                   length: { minimum: 5 }

  has_many :comments

  before_save :generate_preview

  def generate_preview
    self.preview = self.body[0..64]
    # self.save
  end
end
