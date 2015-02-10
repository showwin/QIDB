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
    self['年度'] = get_years(params)
    self['指標番号'] = params['number']
    self['更新日'] = Date.today
    self['指標群'] = params['group']
    self['名称'] = params['name']
    self['意義'] = params['meaning']
    self["必要なデータセット"] = get_datasets(params)
    self['定義の要約'] = { '分子' => params['numer'], '分母' => params['denom'] }
    self['指標の定義/算出方法'] = get_definitions(params)
    self['薬剤一覧の出力'] = params['drug_output'].to_a[0][1] == "yes" ? true : false
    if params['factor_definition'].to_a[0][1] == "yes"
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
    self['指標タイプ'] = params['indicator']
    self['created_at'] = Time.now
  end

  def get_years(params)
    result = []
    opts = ['2008', '2010', '2012', '2014']
    opts.each do |opt|
      if params['year_'+opt] == "true"
        result << opt
      end
    end
    result
  end

  def get_datasets(params)
    set = []
    0.upto(3) do |i|
      set << params['dataset_'+i.to_s] if params['dataset_'+i.to_s].present?
    end
    0.upto(4) do |i|
      set << params['dataset_others_'+i.to_s] if params['dataset_others_'+i.to_s].present?
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

  def self.read_csv(file)
    raise "Unknown file type: #{file.original_filename}" if !(File.extname(file.original_filename) == '.csv')
    csv = CSV.read(file.path)
    columns = []
    csv[0].each do |key|
      columns << key
    end

    flag = true
    1.upto(csv.length-1).each do |row_num|
      @definition = Definition.new
      params = {}

      csv[row_num].each_with_index do |value, index|

        case columns[index]
        when "指標番号"
          params['number'] = value
        when "指標群"
          params['group'] = value
        when "定義書表題"
          params['name'] = value
        when "分母"
          params['denom'] = value
        when "分子"
          params['numer'] = value
        end
      end

      @definition.init_params(params)
      @definition.set_params(params)

      @definition.remove_duplicate
      if !(@definition.save && @definition.create_search_index(params))
        flag = false
      end

    end
    return flag
  end

  def init_params(params)
    params['factor_definition'] = []
    params['factor_definition'][0] = false
    params['order'] = 'asc'
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
