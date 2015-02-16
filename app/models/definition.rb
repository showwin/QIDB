class Definition
  require 'csv'

  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  @@projects = ['qip', 'jha', 'jmha', 'sai', 'min', 'jma', 'ajha', 'nho', 'rofuku', 'jamcf']

  def exist?
    !Definition.where(指標番号: self['指標番号']).empty?
  end

  def remove_duplicate
    @@projects.each do |prjt|
      bup = Definition.where("numbers.#{prjt}" => self['numbers'][prjt]).first
      if bup.present?
        dup.soft_delete = true
        raise if !dup.save
      end
    end
  end

  def set_params(params)
    self['numbers'] = get_numbers(params)
    self['years'] = get_years(params)
    self['group'] = params['group']
    self['name'] = params['name']
    self['meaning'] = params['meaning']
    self['dataset'] = get_datasets(params)
    self['def_summary'] = { 'numer' => params['numer'], 'denom' => params['denom'] }
    self['definitions'] = get_definitions(params)
    self['drag_output'] = params['drug_output'].to_a[0][1] == "yes" ? true : false
    self['factor_definition'] = get_def_risk(params)
    self['method'] = { 'explanation' => params['method_explanation'], 'unit' => params['method_unit'] }
    self['order'] = params['order'].to_a[0][1]
    self['notice'] = params['warning']
    self['standard_value'] = params['standard_value']
    self['references'] = get_references(params)
    self['review_span'] = params['review_span']
    self['indicator'] = params['indicator']
    self['created_at'] = Time.now.strftime('%Y-%m-%d')
    self['soft_delete'] = false
  end

  def get_numbers(params)
    result = {}
    @@projects.each do |prjt|
      if params['project_'+prjt+'_number'].present?
        result[prjt] = params['project_'+prjt+'_number']
      end
    end
    result
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
      denom_set.store("#{id}", {'explanation' => exp, 'data' => data})
      id += 1
    end
    denom_set

    #分子 numer
    id = 1
    numer_set = {}
    while params['numer_exp'+id.to_s].present? do
      exp = params['numer_exp'+id.to_s]
      data = get_def_data(params['numer_file'+id.to_s])
      numer_set.store("#{id}", {'explanation' => exp, 'data' => data})
      id += 1
    end
    numer_set

    set = {'def_denom' => denom_set, 'def_numer' => numer_set}
  end

  def get_def_risk(params)
    id = 1
    risk_set = {}
    while params['risk_exp'+id.to_s].present? do
      exp = params['risk_exp'+id.to_s]
      data = get_def_data(params['risk_file'+id.to_s])
      risk_set.store("#{id}", {'explanation' => exp, 'data' => data})
      id += 1
    end
    risk_set
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
