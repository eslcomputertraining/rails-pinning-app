FactoryGirl.define do
  
  sequence :slug do |n|
    "slug#{n}"
  end

  factory :pin do
    title "Rails Cheatsheet"
    url "http://rails-cheat.com"
    text "A great tool for beginning developers"
    slug
    category Category.find_by_name("rails")
  end

  # There are going to be several types of user built-up here, all under :user...
  factory :user do
    sequence(:email) { |n| "coder#{n}@skillcrush.com" }
    first_name "Skillcrush"
    last_name "Coder"
    password "secret"

    factory :user_with_boards do
      after(:create) do |user|
        user.boards << FactoryGirl.create(:board)
        3.times do
          user.pinnings.create(pin: FactoryGirl.create(:pin), board: user.boards.first)
        end
      end

    factory :user_with_boards_and_followers do #Followers follow the test user...
      after(:create) do |user|
        3.times do
          #user.pinnings.create(pin: FactoryGirl.create(:pin), board: user.boards.first)
	  follower = FactoryGirl.create(:user)
	  Follower.create(user: user, follower_id: follower.id)
        end
      end
    end
    end

    factory :user_with_followees do  #Followees are people test user follows...
      after(:create) do |user|
        3.times do
          Follower.create(user: FactoryGirl.create(:user), follower_id: user.id)
        end
      end
    end
  
  # Okay, we're done with sub-types of user factory here...
  end

  factory :pinning do
    pin
    user
  end

  factory :board do
    name "Test Pins!"
  end

end