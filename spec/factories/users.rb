# frozen_string_literal: true
FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) }
    name { Faker::Name.name }
    username { Faker::Name.name }
    mobilenumber { 'x' }
    confirmed_at { DateTime.now }
    after(:build) do |user|
      user.avatar.attach(io: File.open(Rails.root.join('spec', 'factories', 'images', 'ali.jpeg')),
                         filename: 'ali.jpeg', content_type: 'image/jpeg')
    end
  end
end
