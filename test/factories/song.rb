FactoryBot.define do
  factory :song do
    name 'Ko'
    artist
    album { build(:album, artists: [artist]) }
    playlists { build_list(:playlist, 1) }
  end
end
