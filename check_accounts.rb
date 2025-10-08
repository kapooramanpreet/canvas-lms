#!/usr/bin/env ruby

puts "=" * 80
puts "Canvas LMS Account Information"
puts "=" * 80

puts "\nAll Accounts:"
puts "-" * 80
Account.all.order(:id).each do |account|
  puts "\nID: #{account.id}"
  puts "Name: #{account.name}"
  puts "Root Account ID: #{account.root_account_id}"
  puts "Workflow State: #{account.workflow_state}"
  
  # Count courses
  course_count = account.courses.count
  puts "Courses: #{course_count}"
  
  # Check if this is the site admin
  if account.id == Account.site_admin.id
    puts "Type: SITE ADMIN"
  elsif account.root_account_id == 0 || account.root_account_id.nil?
    puts "Type: ROOT ACCOUNT"
  else
    puts "Type: Sub-account"
  end
end

puts "\n" + "=" * 80
puts "Default Account:"
puts "-" * 80
default_account = Account.default
puts "ID: #{default_account.id}"
puts "Name: #{default_account.name}"
puts "Courses: #{default_account.courses.count}"

puts "\n" + "=" * 80
puts "Site Admin Account:"
puts "-" * 80
site_admin = Account.site_admin
puts "ID: #{site_admin.id}"
puts "Name: #{site_admin.name}"

puts "\n" + "=" * 80
puts "Admin User's Account Associations:"
puts "-" * 80
user = User.find(1)
user.account_users.each do |au|
  puts "\nAccount: #{au.account.name} (ID: #{au.account.id})"
  puts "Role: #{au.role.name}"
end

puts "\n" + "=" * 80
