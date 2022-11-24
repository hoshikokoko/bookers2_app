class Book < ApplicationRecord
  
  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 0, maximum: 200 }
  
  has_one_attached :image
  belongs_to :user
  
end
