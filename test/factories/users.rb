FactoryBot.define do
  factory :user, aliases: [:owner] do
    provider { "google" }
    sequence(:uid) { |i| "uid#{i}" }
    sequence(:name) { |i| "name#{i}" }
    sequence(:email) { |i| "email#{i}@example.com" }
    sequence(:image_url) { |i| "http://example.com/image#{i}.jpg" }
  end
end
