require 'rails_helper'

RSpec.describe DefinitionsController, type: :feature do
  before(:each) do
    @d1 = create_definition
  end

  scenario 'normal user cannot access some page', js: true do
    # トップページにリダイレクト
    visit '/definitions/new'
    expect(page).to have_content('検索キーワード')

    visit "/definitions/#{@d1._id}/edit"
    expect(page).to have_content('検索キーワード')

    visit "/definitions/#{@d1._id}/duplicate"
    expect(page).to have_content('検索キーワード')

    visit "/definitions/#{@d1._id}"
    expect(page).not_to have_content('編集')
    expect(page).not_to have_content('複製')
    expect(page).not_to have_content('削除')
  end

  scenario 'create new definition and show it', js: true do
    # 管理者になるためにログイン
    visit '/login'

    # 新規作成ページへ
    click_link '新規作成'

    # データの入力
    find('#project_rofuku').set(true)
    fill_in('project_rofuku_number', with: '12345')
    find('#year_2014').set(true)
    find('#group').set('循環器系')
    find('#name').set('名称1')
    find('#meaning').set('意義1')
    find('#dataset_3').set(true)
    find('#add_dataset').click
    find('#dataset_others_0').set('データセット1')
    find('#numer').set('定義の要約分子')
    find('#denom').set('定義の要約分母')
    find('#denom_exp1').set('分母の定義1')
    find('#add_denom_exp').click
    find('#denom_exp2').set('分母の定義2')
    find('#numer_exp1').set('分子の定義1')
    find('#add_numer_exp').click
    find('#numer_exp2').set('分子の定義2')
    find('#drug_output__yes').set(true)
    find('#risk_exp1').set('リスクの調整因子の定義1')
    find('#add_risk_def').click
    find('#risk_exp2').set('リスクの調整因子の定義2')
    find('#method_explanation').set('算出方法')
    find('#method_unit').set('単位')
    find('#order__desc').set(true)
    find('#anno_exp1').set('注意事項1')
    find('#ref_val_exp1').set('参考値1')
    find('#add_ref_val_def').click
    find('#ref_val_exp2').set('参考値2')
    find('#ref_info_exp1').set('参考資料1')
    find('#review_span').set('100年に1度')
    select('中央値', from: 'indicator')
    find('#editor').set('作成者1')
    find('#message').set('テストのために作成しました')
    click_button('　作　成　')

    # 登録完了
    expect(page).to have_content('レコードの登録が完了しました')
    expect(page).to have_content('次の定義を登録する')
    expect(page).to have_content('TOPに戻る')

    # 登録した内容の確認
    visit '/definitions/rofuku/12345'
    expect(page).to have_content('労災')
    expect(page).to have_content('12345')
    expect(page).to have_content('2014')
    expect(page).not_to have_content('呼吸器系')
    expect(page).to have_content('循環器系')
    expect(page).to have_content('名称1')
    expect(page).to have_content('意義1')
    expect(page).to have_content('Dファイル')
    expect(page).to have_content('データセット1')
    expect(page).to have_content('定義の要約分子')
    expect(page).to have_content('定義の要約分母')
    expect(page).to have_content('分母の定義1')
    expect(page).to have_content('分母の定義2')
    expect(page).to have_content('分子の定義1')
    expect(page).to have_content('分子の定義2')
    expect(page).to have_content('薬剤一覧の出力: true')
    expect(page).to have_content('リスクの調整因子の定義1')
    expect(page).to have_content('リスクの調整因子の定義2')
    expect(page).to have_content('算出方法')
    expect(page).to have_content('単位')
    expect(page).to have_content('注意事項1')
    expect(page).to have_content('参考値1')
    expect(page).to have_content('参考値2')
    expect(page).to have_content('参考資料1')
    expect(page).to have_content('100年に1度')
    expect(page).to have_content('中央値')
    find('#show_change_log').click
    expect(page).to have_content('変更者: 作成者1　 変更メッセージ: テストのために作成しました')
  end

  scenario 'update definition', js: true do
    # 管理者になるためにログイン
    visit '/login'

    # 定義書ページヘ
    visit '/definitions/qip/64'
    expect(page).to have_content('指標群: 呼吸器系')

    # 編集ページへ
    click_link('編集')
    find('#project_rofuku').set(true)
    fill_in('project_rofuku_number', with: '12345')
    find('#year_2014').set(true)
    find('#group').set('循環器系')
    find('#name').set('名称1')
    find('#meaning').set('意義1')
    find('#dataset_3').set(true)
    find('#add_dataset').click
    find('#dataset_others_1').set('データセット2')
    find('#numer').set('定義の要約分子')
    find('#denom').set('定義の要約分母')
    find('#denom_exp1').set('分母の定義1編集後')
    find('#denom_exp2').set('分母の定義2編集後')
    find('#add_denom_exp').click
    find('#denom_exp3').set('追加した分母の定義3')
    find('#numer_exp1').set('分子の定義1編集後')
    find('#numer_exp2').set('分子の定義2編集後')
    find('#add_numer_exp').click
    find('#numer_exp3').set('追加した分子の定義3')
    find('#drug_output__yes').set(true)
    find('#risk_exp1').set('リスクの調整因子の定義1')
    find('#add_risk_def').click
    find('#risk_exp2').set('リスクの調整因子の定義2')
    find('#method_explanation').set('算出方法編集後')
    find('#method_unit').set('単位編集後')
    find('#order__desc').set(true)
    find('#add_anno_def').click
    find('#anno_exp1').set('注意事項1')
    find('#add_ref_val_def').click
    find('#ref_val_exp1').set('参考値1')
    find('#add_ref_val_def').click
    find('#ref_val_exp2').set('参考値2')
    find('#add_ref_info_def').click
    find('#ref_info_exp1').set('参考資料1')
    find('#review_span').set('100年に1度')
    select('中央値', from: 'indicator')
    find('#editor').set('変更者1')
    find('#message').set('テストのために変更しました')
    click_button('　作　成　')

    # 確認 Modal が出る
    expect(page).to have_content('この定義書の登録により、以下の定義書が上書きされます。')
    expect(page).to have_content('qip: 64')
    click_link('登録')
    expect(page).to have_content('レコードの登録が完了しました')
    expect(page).to have_content('次の定義を登録する')
    expect(page).to have_content('TOPに戻る')

    # 登録した内容の確認
    visit '/definitions/qip/64'
    expect(page).to have_content('労災')
    expect(page).to have_content('12345')
    expect(page).to have_content('2014')
    expect(page).not_to have_content('呼吸器系')
    expect(page).to have_content('循環器系')
    expect(page).to have_content('名称1')
    expect(page).to have_content('意義1')
    expect(page).to have_content('Dファイル')
    expect(page).to have_content('データセット2')
    expect(page).to have_content('定義の要約分子')
    expect(page).to have_content('定義の要約分母')
    expect(page).to have_content('分母の定義1編集後')
    expect(page).to have_content('分母の定義2編集後')
    expect(page).to have_content('追加した分母の定義3')
    expect(page).to have_content('分子の定義1編集後')
    expect(page).to have_content('分子の定義2編集後')
    expect(page).to have_content('追加した分子の定義3')
    expect(page).to have_content('薬剤一覧の出力: true')
    expect(page).to have_content('リスクの調整因子の定義1')
    expect(page).to have_content('リスクの調整因子の定義2')
    expect(page).to have_content('算出方法編集後')
    expect(page).to have_content('単位編集後')
    expect(page).to have_content('注意事項1')
    expect(page).to have_content('参考値1')
    expect(page).to have_content('参考値2')
    expect(page).to have_content('参考資料1')
    expect(page).to have_content('100年に1度')
    expect(page).to have_content('中央値')
    find('#show_change_log').click
    expect(page).to have_content('変更者: 変更者1　 変更メッセージ: テストのために変更しました')
  end

  scenario 'duplicate definition', js: true do
    # 管理者になるためにログイン
    visit '/login'

    # 定義書ページヘ
    visit '/definitions/qip/64'
    expect(page).to have_content('指標群: 呼吸器系')

    # 編集ページへ
    click_link('複製')
    find('#project_rofuku').set(true)
    fill_in('project_rofuku_number', with: '12345')
    find('#year_2014').set(true)
    find('#group').set('循環器系')
    find('#editor').set('変更者1')
    find('#message').set('テストのために変更しました')
    click_button('　作　成　')

    # 確認 Modal が出る
    expect(page).to have_content('レコードの登録が完了しました')
    expect(page).to have_content('次の定義を登録する')
    expect(page).to have_content('TOPに戻る')

    # もとの定義書が変更されていない確認
    visit '/definitions/qip/64'
    expect(page).to have_content('QIP')
    expect(page).to have_content('64')
    expect(page).to have_content('2008')
    expect(page).to have_content('2010')
    expect(page).not_to have_content('2014')
    expect(page).to have_content('呼吸器系')
    find('#show_change_log').click
    expect(page).not_to have_content('変更者: 変更者1　 変更メッセージ: テストのために変更しました')
    expect(page).not_to have_content('アルガトロバン水和物')
    first('.panel-default').click_link('内容を見る').first
    expect(page).to have_content('アルガトロバン水和物')

    # 複製した定義書の確認
    visit '/definitions/rofuku/12345'
    expect(page).to have_content('労災')
    expect(page).to have_content('12345')
    expect(page).to have_content('2008')
    expect(page).to have_content('2010')
    expect(page).to have_content('2014')
    expect(page).to have_content('循環器系')
    expect(page).to have_content('縦隔生検を実施した')
    find('#show_change_log').click
    expect(page).to have_content('変更者: 変更者1　 変更メッセージ: テストのために変更しました')
    expect(page).not_to have_content('アルガトロバン水和物')
    first('.panel-default').click_link('内容を見る').first
    expect(page).to have_content('アルガトロバン水和物')
  end

  scenario 'delete definition', js: true do
    # 管理者になるためにログイン
    visit '/login'

    # 定義書ページヘ
    visit '/definitions/qip/64'
    expect(page).to have_content('指標群: 呼吸器系')

    # 編集ページへ
    click_link('削除')

    # トップページへリダイレクト
    find('#btn-input').set('呼吸器系')
    click_button('　検　索　')

    # 検索結果
    expect(page).not_to have_content('指標番号: 64')
  end

  scenario 'cannot update definition without editor info', js: true do
    # 管理者になるためにログイン
    visit '/login'

    # 定義書ページヘ
    visit '/definitions/qip/64'
    expect(page).to have_content('指標群: 呼吸器系')

    # 編集ページへ
    click_link('編集')
    click_button('　作　成　')

    # エラーメッセージが出る
    expect(page).to have_content('・変更者を記入して下さい')
    expect(page).to have_content('・変更メッセージを記入して下さい')
  end

  scenario 'csv file upload', js: true do
    # あまり使われていないようなのでとりあえずスキップ
  end

  scenario 'download multi-definition PDF' do
    # 管理者になるためにログイン
    visit '/login'

    visit '/'
    click_link('PDFでダウンロード')

    # 出力定義書選択画面へ遷移
    check('all_check')
    click_button('PDFをダウンロード')
    expect(page.response_headers['Content-Type']).to eq('application/pdf')
  end

  describe '#search' do
    it 'should redirect definition page', js: true do
      visit '/definitions/qip/64'

      # 指標ページへリダイレクト
      expect(page).to have_content('指標群: 呼吸器系')
      expect(page).to have_content('指標のPDFをダウンロード')
      expect(page).not_to have_content('アルガトロバン水和物')
      first('.panel-default').click_link('内容を見る').first
      expect(page).to have_content('アルガトロバン水和物')
    end
  end

  describe '#pdf' do
    it 'should download pdf file' do
      visit '/definitions/qip/64'
      expect(page).to have_content('指標のPDFをダウンロード')
      click_link('指標のPDFをダウンロード')
      expect(page.response_headers['Content-Type']).to eq('application/pdf')
    end
  end
end
