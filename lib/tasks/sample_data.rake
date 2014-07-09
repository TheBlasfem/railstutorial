namespace :db do 
	desc "Fill database with fake data"
	task populate: :environment do 
		admin = User.create!(name: "Example User",
                         email: "example@railstutorial.org",
                         password: "foobar",
                         password_confirmation: "foobar",
                         admin: true)
		100.times do |n|
			name = Faker::Name::name
			email = "example-#{n+1}@gmail.com"
			password = "foobar"
			password_confirmation = "foobar"
			User.create!(name: name, email: email, password: password, password_confirmation: password_confirmation) 
		end

		users = User.limit(6).all
    50.times do
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.microposts.create!(content: content) }
    end
	end
end