class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.integer :order_number
      t.string :image_url
      t.text :content
      t.references :issue, foreign_key: true
      
      t.timestamps null: false
    end
  end
end
