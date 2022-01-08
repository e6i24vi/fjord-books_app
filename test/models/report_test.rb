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
    travel_to Time.zone.local(2020, 1, 8, 19, 44, 44) do
      me = User.create(email: 'me@example.com', password: 'password')
      report_me = Report.create(user: me, title: '明日の天気', content: '晴れ')
      assert_equal report_me.created_on, Time.current.to_date
    end
  end
end
