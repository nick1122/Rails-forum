# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts "Foot bar!"

create_account = User.create([email: 'example@gmail.com',password: 'a1234567' , password_confirmation: 'a1234567' , name: 'test'])

create_group = for i in 1..20 do
                 Group.create! ([title: "Group no.#{i}",description: "This is No.#{i}" , user_id: "1" ])
                 GroupUser.create(group_id: i , user_id: 1)
                 for k in 1..30 do
                   Post.create! ([group_id: "#{i}" , content: "This is SEED NO.#{k}" , user_id: "1"])
                 end
end