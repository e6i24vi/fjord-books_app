# frozen_string_literal: true

class ReportTest < ActiveSupport::TestCase
  test '#editable?' do
    me = User.create(email: 'me@example.com', password: 'password')

    she = User.create(email: 'she@example.com', password: 'password')

    report_me = Report.create(user_id: me.id, title: '明日の天気', content: '晴れ')

    assert report_me.editable?(me)
    assert_not report_me.editable?(she)
  end

  test 'create_on' do
    require 'date'
    me = User.create(email: 'me@example.com', password: 'password')
    report_me = Report.create(user_id: me.id, title: '明日の天気', content: '晴れ')
    assert_equal report_me.created_on, Time.zone.today
  end
end
