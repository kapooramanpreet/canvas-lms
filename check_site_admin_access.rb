#!/usr/bin/env ruby

user = User.find(1)

puts "=" * 80
puts "Admin User Credentials"
puts "=" * 80
puts "\nEmail: #{user.pseudonyms.first.unique_id}"
puts "Password: password"

puts "\n" + "=" * 80
puts "Current Account Privileges"
puts "=" * 80

user.account_users.each do |au|
  puts "\nAccount: #{au.account.name} (ID: #{au.account.id})"
  puts "Role: #{au.role.name}"
end

puts "\n" + "=" * 80
puts "Site Admin Access Check"
puts "=" * 80

site_admin = Account.site_admin
puts "\nSite Admin Account ID: #{site_admin.id}"

site_admin_user = site_admin.account_users.where(user: user).first

if site_admin_user
  puts "✅ User HAS Site Admin access"
  puts "Role: #{site_admin_user.role.name}"
else
  puts "❌ User does NOT have Site Admin access"
  puts "\nTo grant Site Admin access, you need to add the user to the Site Admin account."
  puts "The escalate_user_to_admin.rb script only grants access to Account.default (ID 16)."
end

puts "\n" + "=" * 80
puts "Summary"
puts "=" * 80
puts "\nTo access Site Admin (http://localhost:3001/accounts/#{site_admin.id}):"
puts "  Email: #{user.pseudonyms.first.unique_id}"
puts "  Password: password"

if site_admin_user
  puts "  Status: ✅ Access granted"
else
  puts "  Status: ❌ No access - needs to be granted"
end

puts "\n" + "=" * 80
