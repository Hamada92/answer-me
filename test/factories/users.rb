FactoryGirl.define do 
  factory :user do 
    sequence(:email) { |n| n.to_s + "email@queensu.ca" }
    password "password"
    password_confirmation "password"
    sequence(:username) { |n| n.to_s + "ahmad" } 

    factory :toronto_user do 
      sequence(:email) { |n| n.to_s + "email@utoronto.ca" }
      password "password"
      password_confirmation "password"
      sequence(:username) { |n| n.to_s + "torontoUser" } 
    end
  end
end