FactoryBot.define do
  factory :user do
    username 'user'
    email 'user@domain.com'
    password 'abc123'

    factory :user2 do
      username 'user2'
      email 'user2@domain.com'
    end
  end
end
