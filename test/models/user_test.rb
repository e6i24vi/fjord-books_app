# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "name_or_email" do
    user = User.new(email: "zzz@gmail.com",name: "")
    assert_equal "zzz@gmail.com",user.name_or_email
    user.name = "aaabbb"
    assert_equal "aaabbb",user.name_or_email
  end
  test "#follow" do
    me = User.create(email: 'me@example.com', password: 'password')
    she = User.create(email: 'she@example.com', password: 'password')
    assert_not me.following?(she)
    me.follow(she)
    assert me.following?(she)
  end

  test "#unfollow" do
    me = User.create(email: 'me@example.com', password: 'password')
    she = User.create(email: 'she@example.com', password: 'password')
    me.follow(she)
    assert me.following?(she)
    me.unfollow(she)
    assert_not me.following?(she)
  end

  test "#editable?" do
    me = User.create(email: 'me@example.com', password: 'password')
    she = User.create(email: 'she@example.com', password: 'password')

    report_me=Report.new(user_id: me.id, title: '明日の天気', content: '晴れ')

    assert report_me.editable?(me)
    assert_not report_me.editable?(she)
  end



end
