# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string           not null
#  status                 :string
#  photo                  :string
#  role                   :integer          default("0")
#  allow_subscriptions    :boolean          default("true")
#  visible                :boolean          default("true")
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
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
