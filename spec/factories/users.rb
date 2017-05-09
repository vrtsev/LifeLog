# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string(255)      not null
#  status                 :string(255)
#  photo                  :string(255)
#  allow_subscriptions    :boolean          default("1")
#  visible                :boolean          default("1")
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

FactoryGirl.define do
  factory :user do
    name 'Administrator'
    status 'wery shiny weather'
    photo nil
    allow_subscriptions true
    visible true
    sequence(:email) { |i| "example#{i + 2}@mail.com" }
    password 'password'
  end
end
