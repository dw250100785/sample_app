namespace :db do 
  desc "create sample data"
  task :populate => :environment do 
    make_users
    make_microposts
    make_relationships
  end
end

def make_users
  100.times do |n|
    n += 1
    name = "a#{n}"
    email = "a#{n}@a.com"
    pwd = "foobar"

    User.create! name: name, email: email, password: pwd, password_confirmation: pwd
  end

  User.first.toggle! :admin
end

def make_microposts
  User.all.each do |u|
    (rand(20) + 1).times do 
      content = Faker::Lorem.sentence(3)
      u.microposts.create! content: content
    end
  end
end

def make_relationships
  users = User.all
  u = users.first
  followed = users[3..12]
  follower = users[9..18]

  followed.each {|f| u.follow! f}
  follower.each {|f| f.follow! u}
end