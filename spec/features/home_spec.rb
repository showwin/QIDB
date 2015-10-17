require 'rails_helper'

RSpec.describe HomeController, type: :feature do
  before(:each) do
    create_definition
  end

  scenario 'search on top page', js: true do
    visit '/'
    expect(page).to have_content('検索キーワード')

    # 検索
    find('#btn-input').set('呼吸器系')
    click_button('　検　索　')

    # 検索結果
    expect(page).to have_content('指標番号: 64')
    click_link('指標番号: 64')

    # 指標ページ
    expect(page).to have_content('指標群: 呼吸器系')
    expect(page).to have_content('編集')
    expect(page).to have_content('複製')
    expect(page).to have_content('pdf')
    expect(page).not_to have_content('アルガトロバン水和物')
    first('.panel-default').click_link('内容を見る').first
    expect(page).to have_content('アルガトロバン水和物')
  end

  scenario 'download definition csv file' do
    visit '/'
    expect(page).to have_content('Download CSV')
    click_link('Download CSV')
    expect(page.response_headers['Content-Type']).to eq('text/csv')
  end
end
