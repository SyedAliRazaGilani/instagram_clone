FactoryBot.define do
  factory :like do
    association :user, :post
  end
end
