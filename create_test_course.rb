#!/usr/bin/env ruby

#docker-compose exec web bundle exec rails runner create_test_course.rb

puts "=" * 80
puts "Creating Test Course for LTI Testing"
puts "=" * 80

# Get the default account and admin user
account = Account.default
user = User.find(1)

puts "\nUsing Account: #{account.name} (ID: #{account.id})"
puts "Admin User: #{user.name} (ID: #{user.id})"

# Create a test course
course = account.courses.create!(
  name: 'LTI Testing Course',
  course_code: 'LTI-TEST-001',
  workflow_state: 'available',
  enrollment_term: account.default_enrollment_term
)

puts "\n✅ Course created successfully!"
puts "Course ID: #{course.id}"
puts "Course Name: #{course.name}"
puts "Course Code: #{course.course_code}"
puts "Status: #{course.workflow_state}"

# Enroll the admin user as a teacher
enrollment = course.enroll_teacher(user)
enrollment.workflow_state = 'active'
enrollment.save!

puts "\n✅ Admin user enrolled as teacher!"
puts "Enrollment ID: #{enrollment.id}"
puts "Role: Teacher"

# Create a default home page
course.wiki_pages.create!(
  title: 'Home',
  body: '<h1>Welcome to LTI Testing Course</h1><p>This course is set up for testing LTI Tools.</p>',
  workflow_state: 'active'
)

puts "\n✅ Home page created!"

puts "\n" + "=" * 80
puts "Course Setup Complete!"
puts "=" * 80
puts "\nYou can now:"
puts "1. Access the course at: http://localhost:3001/courses/#{course.id}"
puts "2. Configure LTI Tools in Settings → Apps"
puts "3. Test LTI integrations"
puts "\nTo access admin panel:"
puts "- Go to: http://localhost:3001/accounts/#{account.id}"
puts "- Or click 'Admin' in the left sidebar"
puts "=" * 80
