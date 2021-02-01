FactoryGirl.define do
    factory :task do
        title { Faker::Lorem.sentence }
        title { Faker::Lorem.paragraph }
        deadline { Fake::Date.forward } 
        done false
        user_id "1"
        user
    end
end