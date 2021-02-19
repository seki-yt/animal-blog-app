class Article < ApplicationRecord
  validates :title, presence: true
  #=> presence は入力されてるかcheck
  validates :content, presence: true
end
