require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
  end

  test "should get index" do
    get posts_url
    assert_response :success
  end

  test "should get new" do
    get new_post_url
    assert_response :success
  end

  test "should create post" do
    assert_difference("Post.count") do
      post posts_url, params: { post: { category: @post.category, content: @post.content, title: "Unique Title" } }
    end

    assert_redirected_to post_url(Post.last)
  end

  test "should not create an invalid post" do
    # repeat title, should not save
    post posts_url, params: { post: { category: @post.category, content: @post.content, title: @post.title } }

    assert_response :unprocessable_entity
  end

  test "should show post" do
    get post_url(@post)
    assert_response :success
  end

  test "should get edit" do
    get edit_post_url(@post)
    assert_response :success
  end

  test "should update post" do
    patch post_url(@post), params: { post: { category: @post.category, content: @post.content, title: @post.title } }
    assert_redirected_to post_url(@post)
  end

  test "should not update post with non unique title" do
    post posts_url, params: { post: { category: @post.category, content: @post.content, title: "Unique Title" } }
    patch post_url(@post), params: { post: { category: @post.category, content: @post.content, title: "Unique Title" } }
    assert_response :unprocessable_entity
  end

  test "should destroy post" do
    assert_difference("Post.count", -1) do
      delete post_url(@post)
    end

    assert_redirected_to posts_url
  end
end
