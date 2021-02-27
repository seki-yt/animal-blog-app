# == Schema Information
#
# Table name: profiles
#
#  id           :integer          not null, primary key
#  birthday     :date
#  gender       :integer
#  introduction :text
#  nickname     :string
#  subscribed   :boolean          default(FALSE)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :integer          not null
#
# Indexes
#
#  index_profiles_on_user_id  (user_id)
#
class Profile < ApplicationRecord
  enum gender: { male: 0, female: 1, other: 2  }
  belongs_to :user
  has_one_attached :avater
  #=> profileにavatarカラムに追加することができる

  def age
    retutn '不明' unless birthday.present?
    years = Time.zone.now.year - birthday.year
    days = Time.zone.now.yday - birthday.yday
    #=> Time.zone.now.yearで何年が取れる
    #=> yday で一年の始まりからどれくらい日にちが立ったかを取れる
    
    if days < 0
      "#{years - 1}歳"
    else
      "#{years}歳"
    end
  end
end
