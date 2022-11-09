FactoryBot.define do
  factory :comment do
    association :user, :post
    content { 'I am free' }
  end
end
