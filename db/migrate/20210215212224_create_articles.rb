class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :title
      # => stringは短い文を保存する物
      t.text :content
      # => textは長い文を保存する物
      t.timestamps
    end
  end
end
