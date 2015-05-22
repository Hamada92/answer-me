class Question < ActiveRecord::Base
  

  validates :title, presence: true, length: { minimum: 10 }
  validates :body, presence: true
  
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

  def self.unanswered
    includes(:answers).where(answers: { id: nil })
  end

  def self.tagged_with tag
    where(course_name: tag)
  end

  def likes_by user
    self.likes.where(user_id: user.id)
  end


end
