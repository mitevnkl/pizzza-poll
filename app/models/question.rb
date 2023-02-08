class Question < ApplicationRecord
  has_many :votes, dependent: :destroy
  before_validation :strip_answers_text
  validate :no_blank_answers
  validates :title, presence: true
  validates :answers_text, presence: true
  validates :title, format: { with: /\bpizza\b/i, message: "must include the word 'pizza'" }

  def voted_by_ip?(ip_address)
    votes.exists?(voter_ip: ip_address)
  end

  def my_answer(ip_address, answer)
    if votes
      vote = votes.find_by(voter_ip: ip_address)
      if vote && vote.answer == answer
        true
      end
    end
  end

  def strip_answers_text
    self.answers_text = self.answers_text.sub(/\A• /, '')
  end

  def count_votes_for(answer)
    num_of_votes = votes.where(answer: answer).count
    num_of_votes == 1 ? "1 vote" : "#{num_of_votes} votes"
  end

  def no_blank_answers
    if self.answers_text.last(3) == "\n• "
      errors.add(:answers_text, "cannot have a blank answer")
    end
  end

end
