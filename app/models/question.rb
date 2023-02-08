class Question < ApplicationRecord
  has_many :votes, dependent: :destroy
  before_validation :strip_answers_text
  validates :title, presence: true
  validates :answers_text, presence: true
  validates :title, format: { with: /\bpizza\b/i, message: "must include the word 'pizza'" }

  def voted_by_ip?(ip_address)
    votes.exists?(voter_ip: ip_address)
  end

  def strip_answers_text
    self.answers_text = self.answers_text.sub(/\A• /, '')
  end

  def count_votes_for(answer)
    votes.where(answer: answer).count
  end

end
