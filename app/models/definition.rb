class Definition
  require 'csv'

  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  def set_params(params)
    self['プロジェクト名'] = params['project']
    self['年度'] = params['year']
    self['指標番号'] = params['number']
    self['更新日'] = params['updated_date']["(1i)"] \
                  + params['updated_date']["(2i)"] \
                  + params['updated_date']["(3i)"]
    self['指標群'] = params['group']
    self['名称'] = params['name']
    self['意義'] = params['meaning']
    self["必要なデータセット"] = get_datasets(params)
    numer = { '分子' => params['numer'] }
    denom = { '分母' => params['denom'] }
    self['定義の要約'] = [numer, denom]

    self['指標の定義/算出方法'] = get_definitions(params)
    if params['factor_definition'][0] == "yes"
      self['リスクの調整因子の定義'] = true
      self['定義の詳細'] = params['definition_detail']
    else
      self['リスクの調整因子の定義'] = false
    end
    method_exp = { '説明' => params['method_explanation'] }
    method_unit = { '分母' => params['method_unit'] }
    self['指標の算出方法'] = [method_exp, method_unit]
    self['結果提示時の並び順'] = params['order'][0]
    self['測定上の限界/解釈上の注意'] = params['warning']
    self['参考値'] = params['standard_value']
    self['参考資料'] = get_references(params)
    self['定義見直しのタイミング'] = params['review_span']
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
    denom_set = []
    while params['denom_exp'+id.to_s].present? do
      exp = params['denom_exp'+id.to_s]
      data = get_def_data(params['denom_file'+id.to_s])
      definition = {"#{id}" => {'説明' => exp, 'data' => data}}
      denom_set << definition
      id += 1
    end
    denom_set

    #分子 numer
    id = 1
    numer_set = []
    while params['numer_exp'+id.to_s].present? do
      exp = params['numer_exp'+id.to_s]
      data = get_def_data(params['numer_file'+id.to_s])
      definition = {"#{id}" => {'説明' => exp, 'data' => data}}
      numer_set << definition
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

end
