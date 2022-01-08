# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    visit root_url
    @report = reports(:whether)

    fill_in 'Eメール', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
  end

  test 'visiting the index' do
    visit reports_url
    assert_selector 'h1', text: Report.model_name.human
  end

  test 'creating a Report' do
    visit reports_url
    click_on '新規作成'

    fill_in 'タイトル', with: '今日の天気'
    fill_in '内容', with: '晴れ'
    click_on '登録する'

    assert_text '日報が作成されました。'
    assert_text '今日の天気'
    assert_text '晴れ'
    click_on '戻る'
  end

  test 'updating a Report' do
    visit reports_url

    all('tbody tr')[0].click_link '編集'

    fill_in 'タイトル', with: '明後日の天気'
    fill_in '内容', with: '雨'
    click_on '更新する'

    assert_text '日報が更新されました。'
    assert_text '明後日の天気'
    assert_text '雨'
    click_on '戻る'
  end

  test 'destroying a Report' do
    visit reports_url
    page.accept_confirm do
      click_on '削除', match: :first
    end

    assert_text '日報が削除されました。'
  end

  test 'create a Comment' do
    visit reports_url
    all('tbody tr')[0].click_link '詳細'

    fill_in 'session_text', with: '違う'
    click_on 'コメントする'
    assert_text 'コメントが投稿されました。'
    assert_text '違う'
    click_on '戻る'
  end
end
