FactoryBot.define do
  factory :story do
    association :user
    caption { Faker::Lorem.word }
    after(:build) do |story|
      story.image.attach(io: File.open(Rails.root.join('spec', 'factories', 'images', 'ali.jpeg')),
                         filename: 'ali.jpeg', content_type: 'image/jpeg')
    end
  end
end
