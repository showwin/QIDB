require 'rails_helper'

RSpec.describe DefinitionForm do
  describe '#set_params' do
  end

  describe '#numbers' do
    it 'should return definition numbers' do
      params = { 'project_qip_number' => '123', 'project_jha_number' => '456' }
      d = DefinitionForm.new(definition_form_params.update(params))
      expect(d.numbers['qip']).to eq('123')
      expect(d.numbers['jha']).to eq('456')
    end
  end

  describe '#years' do
    it 'should return definition years' do
      params = { 'year_2008' => 'true', 'year_2010' => 'false', 'year_2012' => 'true' }
      d = DefinitionForm.new(definition_form_params.update(params))
      expect(d.years).to eq(%w(2008 2012))
    end
  end

  describe '#datasets' do
    it 'should return definition datasets' do
      params = { 'dataset_0' => 'DPC様式1', 'dataset_others_3' => 'その他データ' }
      d = DefinitionForm.new(definition_form_params.update(params))
      expect(d.datasets).to eq(%w(DPC様式1 その他データ))
    end
  end

  describe '#def_denom' do
    it 'should return definition def_denom' do
      params = { 'denom_exp1' => '分母説明1', 'denom_exp2' => '分母説明2' }
      d = DefinitionForm.new(definition_form_params.update(params))
      expect(d.def_denom).to \
        eq('1' => { 'explanation' => '分母説明1', 'data' => [], 'filename' => nil },
           '2' => { 'explanation' => '分母説明2', 'data' => [], 'filename' => nil })
    end
  end

  describe '#def_numer' do
    it 'should return definition def_numer' do
      params = { 'numer_exp1' => '分子説明1' }
      d = DefinitionForm.new(definition_form_params.update(params))
      expect(d.def_numer).to \
        eq('1' => { 'explanation' => '分子説明1', 'data' => [], 'filename' => nil })
    end
  end

  describe '#def_risks' do
    it 'should return definition def_risks' do
      params = { 'risk_exp1' => 'リスク定義1', 'risk_exp2' => 'リスク定義2' }
      d = DefinitionForm.new(definition_form_params.update(params))
      expect(d.def_risks).to \
        eq('1' => { 'explanation' => 'リスク定義1', 'data' => [], 'filename' => nil },
           '2' => { 'explanation' => 'リスク定義2', 'data' => [], 'filename' => nil })
    end
  end

  describe '#annotation' do
    it 'should return definition annotation' do
      params = { 'anno_exp1' => '注意事項1', 'anno_exp2' => '注意事項2' }
      d = DefinitionForm.new(definition_form_params.update(params))
      expect(d.annotation).to \
        eq('1' => { 'explanation' => '注意事項1', 'data' => [], 'filename' => nil },
           '2' => { 'explanation' => '注意事項2', 'data' => [], 'filename' => nil })
    end
  end

  describe '#standard_value' do
    it 'should return standard_value' do
      params = { 'ref_val_exp1' => '参考値1', 'ref_val_exp2' => '参考値2' }
      d = DefinitionForm.new(definition_form_params.update(params))
      expect(d.standard_value).to \
        eq('1' => { 'explanation' => '参考値1', 'data' => [], 'filename' => nil },
           '2' => { 'explanation' => '参考値2', 'data' => [], 'filename' => nil })
    end
  end

  describe '#references' do
    it 'should return references' do
      params = { 'ref_info_exp1' => '参考資料1', 'ref_info_exp2' => '参考資料2' }
      d = DefinitionForm.new(definition_form_params.update(params))
      expect(d.references).to \
        eq('1' => { 'explanation' => '参考資料1', 'data' => [], 'filename' => nil },
           '2' => { 'explanation' => '参考資料2', 'data' => [], 'filename' => nil })
    end
  end

  describe '#def_data' do
    it 'should return saved data' do
      d_org = create_definition
      params = { 'denom_csv_form1' => ['yes'], 'log_id' => d_org.log_id }
      d = DefinitionForm.new(definition_form_params.update(params))
      expect(d.def_data(1, 'denom')).to \
        eq(d_org.definitions['def_denom']['1']['data'])
    end

    it 'should return data' do
      params = { 'denom_csv_form1' => ['no'] }
      d = DefinitionForm.new(definition_form_params.update(params))
      expect(d.def_data(1, 'denom')).to \
        eq([])
    end
  end

  describe '#def_data_fileaname' do
    it 'should return saved filename' do
      d_org = create_definition
      params = { 'denom_csv_form1' => ['yes'], 'log_id' => d_org.log_id }
      d = DefinitionForm.new(definition_form_params.update(params))
      expect(d.def_data_fileaname(1, 'denom')).to \
        eq(d_org.definitions['def_denom']['1']['filename'])
    end

    it 'should return filename' do
      params = { 'denom_csv_form1' => ['no'] }
      d = DefinitionForm.new(definition_form_params.update(params))
      expect(d.def_data_fileaname(1, 'denom')).to \
        be_nil
    end
  end

  describe '#get_csv_data' do
    # CSVの読み込みは features テストの方でカバー
  end

  describe '#create_search_index' do
    it 'should return all string data' do
      params = { 'ref_info_exp1' => '参考資料1', 'ref_info_exp2' => '参考資料2' }
      d = DefinitionForm.new(definition_form_params.update(params))
      expect(d.search_index).to \
        eq('{"qip"=>"123333"}[]名称{"numer"=>nil, "denom"=>nil}{}{"exp' \
           'lanation"=>nil, "unit"=>nil}{}{}{"1"=>{"explanation"=>"参考資料' \
           '1", "data"=>[], "filename"=>nil}, "2"=>{"explanation"=>"参考資料2",' \
           ' "data"=>[], "filename"=>nil}}2015-10-10')
    end
  end

  describe '#log_id' do
    it 'should return log_id from params' do
      params = { 'log_id' => '10' }
      d = DefinitionForm.new(definition_form_params.update(params))
      expect(d.log_id).to eq(10)
    end

    it 'should return new log_id' do
      create_definition
      params = {}
      d = DefinitionForm.new(definition_form_params.update(params))
      expect(d.log_id).to eq(1)
    end
  end
end
