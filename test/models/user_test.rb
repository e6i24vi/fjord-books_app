# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'name_or_email' do
    user = User.new(email: 'zzz@gmail.com', name: '')
    assert_equal 'zzz@gmail.com', user.name_or_email
    user.name = 'aaabbb'
    assert_equal 'aaabbb', user.name_or_email
  end

  test '#follow' do
    me = User.create(email: 'me@example.com', password: 'password')
    she = User.create(email: 'she@example.com', password: 'password')
    assert_not me.active_relationships.where(following_id: she.id).exists?
    me.follow(she)
    assert me.active_relationships.where(following_id: she.id).exists?
  end
  test '#unfollow' do
    me = User.create(email: 'me@example.com', password: 'password')
    she = User.create(email: 'she@example.com', password: 'password')
    me.follow(she)
    assert me.active_relationships.where(following_id: she.id).exists?
    me.unfollow(she)
    assert_not me.active_relationships.where(following_id: she.id).exists?
  end

  test '#following?' do
    me = User.create(email: 'me@example.com', password: 'password')
    she = User.create(email: 'she@example.com', password: 'password')
    me.follow(she)
    assert me.following?(she)
    me.unfollow(she)
    assert_not me.following?(she)
  end

  test '#follow_by?' do
    me = User.create(email: 'me@example.com', password: 'password')
    she = User.create(email: 'she@example.com', password: 'password')
    assert_not me.following?(she)
    me.follow(she)
    assert she.followed_by?(me)
    me.unfollow(she)
    assert_not she.followed_by?(me)
  end
end
