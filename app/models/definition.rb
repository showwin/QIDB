class Definition
  require 'csv'

  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  def exist?
    !Definition.where(指標番号: self['指標番号']).empty?
  end

  def remove_duplicate
    Definition.where(指標番号: self['指標番号']).destroy if self.exist?
  end

  def set_params(params)
    self['プロジェクト名'] = params['project']
    self['年度'] = params['year']
    self['指標番号'] = params['number']
    self['指標群'] = params['group']
    self['名称'] = params['name']
    self['意義'] = params['meaning']
    self["必要なデータセット"] = get_datasets(params)
    self['定義の要約'] = { '分子' => params['numer'], '分母' => params['denom'] }

    self['指標の定義/算出方法'] = get_definitions(params)
    if params['factor_definition'][0] == "yes"
      self['リスクの調整因子の定義'] = true
      self['定義の詳細'] = params['definition_detail']
    else
      self['リスクの調整因子の定義'] = false
    end
    self['指標の算出方法'] = { '説明' => params['method_explanation'], '単位' => params['method_unit'] }
    self['結果提示時の並び順'] = params['order'][0]
    self['測定上の限界/解釈上の注意'] = params['warning']
    self['参考値'] = params['standard_value']
    self['参考資料'] = get_references(params)
    self['定義見直しのタイミング'] = params['review_span']
    self['created_at'] = Time.now
  end

  def get_datasets(params)
    id = 1
    set = []
    while params['dataset'+id.to_s].present? do
      data = params['dataset'+id.to_s]
      set << data if !set.include?(data)
      id += 1
    end
    set
  end

  def get_references(params)
    id = 1
    set = []
    while params['reference'+id.to_s].present? do
      data = params['reference'+id.to_s]
      set << data if !set.include?(data)
      id += 1
    end
    set
  end

  def get_definitions(params)
    #分母 denom
    id = 1
    denom_set = {}
    while params['denom_exp'+id.to_s].present? do
      exp = params['denom_exp'+id.to_s]
      data = get_def_data(params['denom_file'+id.to_s])
      denom_set.store("#{id}", {'説明' => exp, 'data' => data})
      id += 1
    end
    denom_set

    #分子 numer
    id = 1
    numer_set = {}
    while params['numer_exp'+id.to_s].present? do
      exp = params['numer_exp'+id.to_s]
      data = get_def_data(params['numer_file'+id.to_s])
      numer_set.store("#{id}", {'説明' => exp, 'data' => data})
      id += 1
    end
    numer_set

    set = {'分母の定義' => denom_set, '分子の定義' => numer_set}
  end

  def get_def_data(file)
    return [] if !file
    raise "Unknown file type: #{file.original_filename}" if !(File.extname(file.original_filename) == '.csv')
    csv = CSV.read(file.path)
    data = []
    csv[0].each do |key|
      data << {key => []}
    end
    1.upto(csv.length-1).each do |row_num|
      csv[row_num].each_with_index do |value, index|
        data[index][data[index].keys[0]] << value
      end
    end
    data
  end

  def create_search_index(params)
    id = params['number']
    letters = params['project'].to_s + \
              params['year'].to_s + \
              params['number'].to_s + \
              params['group'].to_s + \
              params['name'].to_s + \
              params['meaning'].to_s + \
              get_datasets(params).join.to_s + \
              params['numer'].to_s + \
              params['denom'].to_s + \
              get_definitions(params).values.join.to_s + \
              params['definition_detail'].to_s + \
              params['method_explanation'].to_s + \
              params['method_unit'].to_s + \
              params['warning'].to_s + \
              params['standard_value'].to_s + \
              get_references(params).to_s + \
              params['review_span'].to_s + \
              Time.now.to_s
    StringData.create_record(id, letters)
  end
end
