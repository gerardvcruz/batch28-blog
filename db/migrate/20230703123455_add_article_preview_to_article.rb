class AddArticlePreviewToArticle < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :preview, :string
  end
end
