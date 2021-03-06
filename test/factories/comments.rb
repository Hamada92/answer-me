FactoryGirl.define do
  factory :comment do 
    user
    body "comment"

    factory :answer_comment do 
      association :commentable, factory: :answer
    end

    factory :question_comment do 
      association :commentable, factory: :question
    end

    factory :group_comment do 
      association :commentable, factory: :group
    end

  end
end
