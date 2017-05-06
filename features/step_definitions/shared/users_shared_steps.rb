class String
  def true?
    self == 'true'
  end
end

Given(/^I as guest/) do
  logout(:user)
end

Given(/^user with name '([^']*)' and email '([^']*)'/) do |name, email|
  User.create(name: name, email: email, password: 'password')
end

Given(/^following users:/) do |table|
  table.hashes.each do |data|
    User.create \
      name: data['name'],
      email: data['email'],
      visible: data['visible'].true?,
      password: 'password'
  end
end

And(/^i sign in as '([^']*)'/) do |email|
  logout(:user)
  user = User.find_by email: email
  login_as(user)
end