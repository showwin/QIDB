require 'rails_helper'

RSpec.describe HomeController, type: :feature do
  before(:each) do
    create_definition
  end

  scenario 'search on top page', js: true do
    visit '/'
    expect(page).to have_content('すべてをCSVでダウンロード')

    # 検索
    find('#query-project').set('jha')
    find('#query-keyword').set('呼吸器系')
    click_button('　検　索　')

    # 検索結果
    expect(page).to have_content('検索結果: 1 件')
    expect(page).to have_content('指標番号: 64 (qip)')
    expect(page).to have_content('2 (jha)')
    expect(page).to have_content('指標群: 呼吸器系')
    expect(page).to have_content('名称: 縦隔生検を実施した症例において、手技後に治療を要する気胸や血胸が生じた症例の割合')
    expect(page).to have_content('分母: 18歳以上で、経胸壁的肺/縦隔生検を受けた症例')
    expect(page).to have_content('分子: 分母のうち、胸腔ドレナージを受けた症例')
    click_link('指標番号: 64')

    # 指標ページ
    expect(page).to have_content('指標群: 呼吸器系')
    expect(page).to have_content('指標のPDFをダウンロード')
    expect(page).not_to have_content('アルガトロバン水和物')
    first('.panel-default').click_link('内容を見る')
    expect(page).to have_content('アルガトロバン水和物')
  end

  scenario 'download definition csv file' do
    visit '/'
    expect(page).to have_content('CSVでダウンロード')
    expect(page).to have_content('PDFでダウンロード')
    click_link('CSVでダウンロード')
    expect(page.response_headers['Content-Type']).to eq('text/csv')
  end
end
