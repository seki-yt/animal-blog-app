# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  content    :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Article < ApplicationRecord
  validates :title, presence: true
  #=> presence は入力されてるかcheck
  validates :title, length: { minimum: 2, maximum: 100 }
  #=> lengthは文字の長さを指定
  validates :title, format: { with: /\A(?!\@)/ }

  validates :content, presence: true
  validates :content, length: { minimum: 10 }
  validates :content, uniqueness: true

  validate :validate_title_and_content_length
  #=> 独自のvalidateの場合はsは付けない

  def display_created_at
     I18n.l(self.created_at, format: :default)
  end

  private
  def validate_title_and_content_length
    char_count = self.title.length + self.content.length
    unless char_count > 100
      errors.add(:content, '100文字以上で！')
      #=> errors.addで独自のerrorを追加する
      #=> :content はカラム指定をしている。
    end
  end
end
