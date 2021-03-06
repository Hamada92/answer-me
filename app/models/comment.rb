class Comment < ActiveRecord::Base

  has_many :notifications, as: :notifier, dependent: :destroy
  belongs_to :commentable, polymorphic: true, touch: true
  belongs_to :user

  validates :body, presence: true
  
end
