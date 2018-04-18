FactoryBot.define do
  factory :album do
    name 'Hexadic III'
    artists { build_list(:artist, 1) }
  end
end
