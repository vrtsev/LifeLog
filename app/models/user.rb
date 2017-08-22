# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string           not null
#  status                 :string
#  photo                  :string
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

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable
  mount_uploader :photo, PhotoUploader

  has_many :credentials, dependent: :destroy
  accepts_nested_attributes_for :credentials

  # Publication relations
  has_many :publication_posts, class_name: 'Publication::Post'
  has_many :publication_categories, class_name: 'Publication::Category'
  has_many :publication_comments, class_name: 'Publication::Comment'
  has_many :active_relationships,  class_name:  'Publication::Relationship',
                                   foreign_key: 'follower_id',
                                   dependent:   :destroy
  has_many :passive_relationships, class_name:  'Publication::Relationship',
                                   foreign_key: 'followed_id',
                                   dependent:   :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  # Diary relations
  has_many :diary_posts, class_name: 'Diary::Post'
  has_many :diary_categories, class_name: 'Diary::Category'
  has_many :diary_comments, class_name: 'Diary::Comment'

  # Objective relations
  has_many :goals, class_name: 'Objective::Goal'
  has_many :goal_categories, class_name: 'Objective::Category'

  enum role: %i[default_user admin support]

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def self.create_for_oauth(auth)
    create \
      name: auth.info.name,
      email: auth.info.email,
      password: Devise.friendly_token[0, 10]
  end
end
