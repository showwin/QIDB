# use CreateDefinition Module to create mock instead of FactoryGirl
module CreateDefinition
  def create_definition
    @definition = Definition.new
    @definition['log_id'] = 1
    @definition['numbers'] = { 'qip' => '64', 'jha' => '2' }
    @definition['years'] = %w(2008 2010)
    @definition['group'] = '呼吸器系'
    @definition['name'] = '縦隔生検を実施した症例において、手技後に治療を要する気胸や血胸が生じた症例の割合'
    @definition['meaning'] = '縦隔生検の後に気胸や血胸の治療を行うのは、手技に伴う合併症の可能性が高い。'
    @definition['dataset'] = %w(DPC様式1 EFファイル データ1)
    @definition['def_summary'] = { 'numer' => '分母のうち、胸腔ドレナージを受けた症例', \
                                   'denom' => '18歳以上で、経胸壁的肺/縦隔生検を受けた症例' }
    def_denom1 = { 'explanation' => '分母の定義1', \
                   'data' => [
                     { '薬価基準コード7桁' => %w(3399007 3399100 3999411 2190408 2190409 2190410 2190411 2190412 2190413 2190414 2190415 2190416 2190417) },
                     { '成分名' => %w(アスピリン アスピリン・ダイアルミネート オザグレルナトリウム
                                   アルガトロバン水和物 水和物1 水和物2 水和物3 水和物4 水和物5 水和物6 水和物7 水和物8 水和物9) },
                     { '2010' => %w(true true true true true false true false false true true false true) },
                     { '2012' => %w(true true true true true true false true false true false true true) },
                     { '2014' => %w(false false false false false false false true false false false true false) }],
                   'filename' => nil }
    def_denom2 = { 'explanation' => '分母の定義2', 'data' => nil, 'filename' => nil }
    def_denom = { '1' => def_denom1, '2' => def_denom2 }
    def_numer1 = { 'explanation' => '分子1',
                   'data' => [
                     { '薬価基準コード7桁' => %w(3959402) },
                     { '成分名' => %w(アルテプラーゼ) },
                     { '2010' => %w(true) },
                     { '2012' => %w(true) },
                     { '2014' => %w(false) }],
                   'filename' => nil }
    def_numer2 = { 'explanation' => '分子2', 'data' => nil, 'filename' => nil }
    def_numer = { '1' => def_numer1, '2' => def_numer2 }
    @definition['definitions'] = { 'def_denom' => def_denom, 'def_numer' => def_numer }
    @definition['drug_output'] = false
    @definition['def_risks'] = { '1' => { 'explanation' => 'リスクの定義1',
                                          'data' => nil,
                                          'filename' => nil } }
    @definition['method'] = { 'explanation' => '分子÷分母', 'unit' => 'パーセント' }
    @definition['order'] = 'asc'
    @definition['annotation'] = {}
    @definition['standard_value'] = {}
    @definition['references'] = {}
    @definition['review_span'] = {}
    @definition['indicator'] = 'リスク調整'
    @definition['created_at'] = '2015-10-08'
    s_idx = 'qip64jha2jmha321呼吸器系経胸壁的肺/縦隔生検を実施した症例において、手技後に治療を要する' \
            '気胸や血胸が生じた症例の割合経胸壁的肺/縦隔生検の後に気胸や血胸の治療を行うのは、' \
            '手技に伴う合併症の可能性が高い。DPC様式1EFファイルデータ1分母のうち、胸腔ドレナージを受けた症例18歳以上で、' \
            '肺、気管、気管支、あるいは縦隔腫瘍が疑われ、かつ経胸壁的肺/縦隔生検を受けた症例'
    @definition['search_index'] = s_idx
    @definition['soft_delete'] = false
    @definition.save
    @definition
  end
end

RSpec.configure do |config|
  config.include CreateDefinition
end
