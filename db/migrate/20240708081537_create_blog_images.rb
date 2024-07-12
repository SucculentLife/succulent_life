class CreateBlogImages < ActiveRecord::Migration[6.1]
  def change
    create_table :blog_images do |t|
      t.string :image
      t.references :blog, foreign_key: true, null: false
      t.timestamps
    end
  end
end
