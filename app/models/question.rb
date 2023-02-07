class Question < ApplicationRecord
  has_many :votes, dependent: :destroy
  validates :title, presence: true
  validates :answers_text, presence: true
end
