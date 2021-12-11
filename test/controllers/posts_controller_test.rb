# frozen_string_literal: true

require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  test 'should get create' do
    get posts_create_url
    assert_response :success
  end

  test 'should get new' do
    get posts_new_url
    assert_response :success
  end
end
