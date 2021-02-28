# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :articles, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :favorite_articles, through: :likes, source: :article
  has_one :profile, dependent: :destroy
  #=> rails Activerecordでつなぐために書いている

  delegate :age, :birthday, :gender, to: :profile, allow_nil: true
  #=> delegateは簡単にbirthdayなどのメゾットを作れる
  #=> allow_nil: true でぼっち演算子を勝手に付けてくれる

  def has_written?(article)
    articles.exists?(id: article.id)
  end

  def has_liked(article)
    likes.exists?(article_id: article.id)
  end

  def display_name
    # ぼっち演算子
    # profileがnilじゃなかったらnicknameを使うとなる
    profile&.nickname || self.email.split('@').first
  end

  def prepare_profile
    profile || build_profile
  end

  def avatar_image
    if profile&.avater&.attached?
      profile.avater
    else
      'default-avatar.png'
    end
  end
end
