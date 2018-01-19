FactoryBot.define do
  factory :user do
    name "Example User"
    email "user@example.com"
    password "123456"
    password_confirmation "123456"
    admin true
    activated true
    activated_at Time.zone.now
  end
  
  factory :other_user, class: User do
    name "Example User 1"
    email "user1@example.com"
    password "123456"
    password_confirmation "123456"
    activated false
  end
  
  
end