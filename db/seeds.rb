# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Enrollment.destroy_all
Lesson.destroy_all
Review.destroy_all
User.destroy_all

PASSWORD = 123

# tutor admin user as the first user in the DB
User.create(
  username: "admin",
  email: "admin@user.com",
  password: "#{PASSWORD}",
  is_tutor: true
)

#create ten students
10.times do 
    username = Faker::Name.first_name
    User.create(
      username: username,
      email: "#{username}@g.com",
      password: "#{PASSWORD}",
      is_tutor: false
    )
end

# create 2 teachers
2.times do |i|
    username = "something#{i}"
    User.create(
      username: username,
      email: "#{username}@g.com",
      password: "#{PASSWORD}",
      is_tutor: true
    )
end

#create 4 lessons for tutor_id = 12 and tutor_id  = 13
Lesson.create(
        subject: "rails1", 
        description: "wow" ,
        cost: 100, 
        time_of_lesson: DateTime.new(2022, 8, 29, 22, 35, 0), 
        tutor_id: 12
        );


Lesson.create(
        subject: "rails2", 
        description: "wow" ,
        cost: 100, 
        time_of_lesson: DateTime.new(2022, 8, 29, 22, 35, 0), 
        tutor_id: 13
      );   

Lesson.create(
  subject: "rails3", 
  description: "wow" ,
  cost: 100, 
  time_of_lesson: DateTime.new(2022, 8, 30, 22, 35, 0), 
  tutor_id: 12
);  

Lesson.create(
  subject: "rails4", 
  description: "wow" ,
  cost: 100, 
  time_of_lesson: DateTime.new(2022, 9, 30, 22, 35, 0), 
  tutor_id: 13
);  

#students from 1 to 5 are enrolled into lesson1 and left their review for tutor_id 12
(1..5).each do |i|
    Enrollment.create(student_id: i, lesson_id: 1, is_accepted: false);
    Review.create(rating:rand(1..5), body: Faker::Hacker.say_something_smart, student_id: i, tutor_id: 12)
end

#students from 6 to 10 are enrolled into lesson1 and left their review for tutor_id 13
(6..10).each do |i|
    Enrollment.create(student_id: i, lesson_id: 2, is_accepted: false);
    Review.create(rating:rand(1..5), body: Faker::Hacker.say_something_smart, student_id: i, tutor_id: 13)
end


users = User.all
enrollment = Enrollment.all
reivews = Review.all
lessons = Lesson.all


puts Cowsay.say("Generated #{users.count} users", :frogs)
puts Cowsay.say("Generated #{enrollment.count} enrollment", :dragon)
puts Cowsay.say("Generated #{reivews.count} reviews", :koala)
puts Cowsay.say("Generated #{lessons.count} lessons", :cow)

