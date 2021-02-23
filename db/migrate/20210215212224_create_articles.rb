class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.references :user, null: false
      #=> user_idのこと
      t.string :title, null: false
      # => stringは短い文を保存する物
      t.text :content, null: false
      # => textは長い文を保存する物
      t.timestamps
    end
  end
end
