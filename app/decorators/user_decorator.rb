# frozen_string_literal: true

module UserDecorator
  def display_name
    # ぼっち演算子
    # profileがnilじゃなかったらnicknameを使うとなる
    profile&.nickname || self.email.split('@').first
  end

  def avatar_image
    if profile&.avater&.attached?
      profile.avater
    else
      'default-avatar.png'
    end
  end
end
