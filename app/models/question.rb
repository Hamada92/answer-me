class Question < ActiveRecord::Base
  validates :title, presence: true, length: { minimum: 10 }
  validates :body, presence: true
  
  belongs_to :user
  has_many :answers, as: :commentable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  def self.unanswered
    includes(:answers).where(answers: { id: nil })
  end
end
