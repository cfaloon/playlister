FactoryBot.define do
  factory :playlist do
    name 'Playlist Alchemy'
    user
    played_at 7.days.ago
  end
end
