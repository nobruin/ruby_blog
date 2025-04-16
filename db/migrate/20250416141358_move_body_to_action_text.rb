class MoveBodyToActionText < ActiveRecord::Migration[8.0]
  def change
    BlogPost.find_each do |post|
      post.content = post.body
      post.save!
    end
    remove_column :blog_posts, :body, :text
  end
end
