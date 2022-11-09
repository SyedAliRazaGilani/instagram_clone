FactoryBot.define do
  factory :post do
    association :user
    caption { Faker::Lorem.word }
    after(:create) do |post|
      post.images.attach(io: File.open(Rails.root.join('spec', 'factories', 'images', 'ali.jpeg')),
                         filename: 'ali.jpeg', content_type: 'image/jpeg')
    end
  end
end
