require "test_helper"

class ArticleTest < ActiveSupport::TestCase
  test "should save a valid article" do 
    article = Article.new
    article.name = "Article name"
    article.body = "Some body once told me"

    assert article.save, "Complete article saved"
  end

  test "should not save an invalid article" do 
    article = Article.new
    article.body = "Some body once told me"

    assert_not article.save, "Invalid article saved"
  end

  test "should generate a preview after saving" do
    article = Article.new
    article.name = "New article"
    article.body = "Lorem ipsum dolor sit amet"

    article.save

    assert_not_empty article.preview, "Article preview is empty"
  end
end
