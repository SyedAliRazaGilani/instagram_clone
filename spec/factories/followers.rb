# frozen_String_literal: true

FactoryBot.define do
  factory :follower do
    association :user, :follower
    user_id { association :user }
    follower_id {  }
    friend { Faker::Boolean.boolean }
  end
end
