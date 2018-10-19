require 'test_helper'

class SignupUserTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(username:"john", email: "john@example.com", password: "password", admin: true)
    @admin = User.create(username:"john", email: "john@example.com", password: "password", admin: true)
  end

  # test "should get signup form and signup user" do
  #   get signup_path
  #   assert_template 'users/new'
  #   assert_difference 'User.count', 1 do
  #     post_via_redirect users_path, user: {username:"john3", email: "john3@example.com", password: "password"}
  #   end
  #   assert_template 'users/show'
  #   assert_match "john", response.body
  #   assert_match "0 articles", response.body
  # end

  test "article should be created by admin user" do
    sign_in_as(@admin, "password") 
    get new_article_path
    assert_template 'articles/new'
    assert_difference 'Article.count', 1 do
      post_via_redirect articles_path, article: {title: "TitleTitle", description: "DescriptionDescription", user: @admin}
    end
    assert_template 'articles/show'
    assert_match "TitleTitle", response.body
    assert_match "DescriptionDescription", response.body
    assert_match "Article was successfully created", response.body
  end

end