require 'rails_helper'

RSpec.describe Definition, type: :model do
  it 'should create definition' do
    expect(Definition.all.count).to eq(0)
    create_definition
    d = Definition.last
    expect(d.group).to eq('呼吸器系')
    expect(Definition.all.count).to eq(1)
  end

  describe '#find_duplicates' do
    it 'should return array of duplicated list' do
      create_definition
      d = create_definition
      expect(d.find_duplicates).to eq([%w(qip 64), %w(jha 2)])
    end
  end

  describe '#remove_duplicate' do
    it 'should soft delete duplicated definition' do
      d_org = create_definition
      expect(d_org.soft_delete).to be_falsey
      d = create_definition
      d.remove_duplicate
      # refresh d_org params
      d_org = Definition.first
      expect(d_org.soft_delete).to be_truthy
    end
  end

  describe '#tmp_save' do
    it 'should soft delete' do
      d_org = create_definition
      expect(d_org.soft_delete).to be_falsey
      d_org.tmp_save!
      expect(d_org.soft_delete).to be_truthy
    end
  end

  describe '#set_params' do
  end

  describe '#get_numbers' do
    it 'should return definition numbers' do
      d = create_definition
      params = { 'project_qip_number' => 123, 'project_jha_number' => 456 }
      expect(d.get_numbers(params)['qip']).to eq(123)
      expect(d.get_numbers(params)['jha']).to eq(456)
    end
  end

  describe '#get_years' do
    it 'should return definition years' do
      d = create_definition
      params = { 'year_2008' => 'true', 'year_2010' => 'false', 'year_2012' => 'true' }
      expect(d.get_years(params)).to eq(%w(2008 2012))
    end
  end

  describe '#get_datasets' do
    it 'should return definition datasets' do
      d = create_definition
      params = { 'dataset_0' => 'DPC様式1', 'dataset_others_3' => 'その他データ' }
      expect(d.get_datasets(params)).to eq(%w(DPC様式1 その他データ))
    end
  end

  describe '#get_definitions' do
    it 'should return definition definitions' do
      d = create_definition
      params = { 'denom_exp1' => '分母説明1', 'denom_exp2' => '分母説明2', 'numer_exp1' => '分子説明1' }
      expect(d.get_definitions(params, 1)).to \
        eq('def_denom' => { '1' => { 'explanation' => '分母説明1', 'data' => nil, 'filename' => nil },
                            '2' => { 'explanation' => '分母説明2', 'data' => nil, 'filename' => nil } },
           'def_numer' => { '1' => { 'explanation' => '分子説明1', 'data' => nil, 'filename' => nil } })
    end
  end

  describe '#get_def_risk' do
    it 'should return definition def_risk' do
      d = create_definition
      params = { 'risk_exp1' => 'リスク定義1', 'risk_exp2' => 'リスク定義2' }
      expect(d.get_def_risk(params)).to \
        eq('1' => { 'explanation' => 'リスク定義1', 'data' => nil, 'filename' => nil },
           '2' => { 'explanation' => 'リスク定義2', 'data' => nil, 'filename' => nil })
    end
  end

  describe '#get_def_anno' do
    it 'should return definition def_anno' do
      d = create_definition
      params = { 'anno_exp1' => '注意事項1', 'anno_exp2' => '注意事項2' }
      expect(d.get_def_anno(params)).to \
        eq('1' => { 'explanation' => '注意事項1', 'data' => nil, 'filename' => nil },
           '2' => { 'explanation' => '注意事項2', 'data' => nil, 'filename' => nil })
    end
  end

  describe '#get_def_ref_val' do
    it 'should return def_ref_val' do
      d = create_definition
      params = { 'anno_exp1' => '注意事項1', 'anno_exp2' => '注意事項2' }
      expect(d.get_def_anno(params)).to \
        eq('1' => { 'explanation' => '注意事項1', 'data' => nil, 'filename' => nil },
           '2' => { 'explanation' => '注意事項2', 'data' => nil, 'filename' => nil })
    end
  end

  describe '#get_def_ref_info' do
    it 'should return def_ref_info' do
      d = create_definition
      params = { 'ref_info_exp1' => '参考資料1', 'ref_info_exp2' => '参考資料2' }
      expect(d.get_def_ref_info(params)).to \
        eq('1' => { 'explanation' => '参考資料1', 'data' => nil, 'filename' => nil },
           '2' => { 'explanation' => '参考資料2', 'data' => nil, 'filename' => nil })
    end
  end

  describe '#get_def_data' do
    it 'should return data and filename' do
      d = create_definition
      params = { 'denom_csv_form1' => ['yes'] }
      expect(d.get_def_data(1, 'denom', params, 1)).to \
        eq([d.definitions['def_denom']['1']['data'], d.definitions['def_denom']['1']['filename']])
    end
  end

  describe '#get_csv_data' do
    # CSVの読み込みは features テストの方でカバー
  end

  describe '#create_search_index' do
    # メソッド修正後に記述
  end

  describe '#create_log_id' do
    it 'should return log_id from params' do
      d = create_definition
      params = { 'log_id' => '10' }
      expect(d.create_log_id(params)).to eq(10)
    end

    it 'should return new log_id' do
      create_definition
      d = Definition.new
      params = {}
      expect(d.create_log_id(params)).to eq(1)
    end
  end

  describe '#read_csv' do
    # CSVの読み込みは features テストの方でカバー
  end

  describe '#search' do
    it 'should search coreectly' do
      create_definition
      result = Definition.search(%w(縦隔生検 呼吸器系))
      expect(result.size).to eq(1)
      expect(result[0].group).to eq('呼吸器系')
      result = Definition.search(%w(存在しない キーワード))
      expect(result.size).to eq(0)
    end
  end
end
