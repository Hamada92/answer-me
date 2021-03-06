class Tag < ActiveRecord::Base
  
  has_many :taggings, dependent: :destroy
  has_many :questions, through: :taggings

  def unanswered_questions
    questions.where(num_answers: 0)
  end

  def self.with_university university
    Tag.where(university: university)
  end

  def self.names_with university, category
    Tag.where(university: university, category: category).pluck(:name)
  end

  def self.all_universities
    Tag.pluck(:university).uniq
  end

end
