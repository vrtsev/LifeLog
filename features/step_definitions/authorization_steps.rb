And(/^I fill registration fields with data:/) do |table|
  data = table.hashes.first
  fill_in('user[name]', with: data['name'].to_s)
  fill_in('user[email]', with: data['email'].to_s)
  fill_in('user[password]', with: data['password'].to_s)
  fill_in('user[password_confirmation]', with: data['password'].to_s)
end