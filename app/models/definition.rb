class Definition
  require 'csv'

  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  @@projects = ['qip', 'jha', 'jmha', 'sai', 'min', 'jma', 'ajha', 'nho', 'rofuku', 'jamcf']

  def find_duplicates
    dups = []
    @@projects.each do |prjt|
      next if self['numbers'][prjt].blank?
      bup = Definition.where('soft_delete' => false)
                      .where("numbers.#{prjt}" => self['numbers'][prjt]).first
      if bup.present?
        dups << [prjt, dup.numbers[prjt]]
      end
    end
    dups
  end

  def remove_duplicate
    @@projects.each do |prjt|
      next if self['numbers'][prjt].blank?
      dups = Definition.where('soft_delete' => false)
                       .where("numbers.#{prjt}" => self['numbers'][prjt])
      if dups.present?
        dups.each do |dup|
          dup.soft_delete = true
          raise if !dup.save
        end
      end
    end
  end

  def tmp_save
    self['soft_delete'] = true
    self.save
  end

  def set_params(params)
    self['log_id'] = create_log_id(params)
    self['numbers'] = get_numbers(params)
    self['years'] = get_years(params)
    self['group'] = params['group']
    self['name'] = params['name']
    self['meaning'] = params['meaning']
    self['dataset'] = get_datasets(params)
    self['def_summary'] = { 'numer' => params['numer'], 'denom' => params['denom'] }
    self['definitions'] = get_definitions(params, self.log_id)
    self['drug_output'] = params['drug_output'][0] == "yes" ? true : false
    if params['factor_definition'][0] == "yes"
      self['factor_definition'] = true
      self['factor_definition_detail'] = params['definition_detail']
    else
      self['factor_definition'] = false
    end
    self['method'] = { 'explanation' => params['method_explanation'], 'unit' => params['method_unit'] }
    self['order'] = params['order'][0]
    self['annotation'] = params['annotation']
    self['standard_value'] = params['standard_value']
    self['references'] = get_references(params)
    self['review_span'] = params['review_span']
    self['indicator'] = params['indicator']
    self['created_at'] = Time.now
    self['search_index'] = create_search_index(params)
    self['soft_delete'] = false
    self['log_id'] = create_log_id(params)
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

  def get_definitions(params, log_id)
    #分母 denom
    id = 1
    denom_set = {}
    while params['denom_exp'+id.to_s].present? do
      exp = params['denom_exp'+id.to_s]
      data = get_def_data(id, 'denom', params, log_id)
      denom_set.store("#{id}", {'explanation' => exp, 'data' => data})
      id += 1
    end
    denom_set

    #分子 numer
    id = 1
    numer_set = {}
    while params['numer_exp'+id.to_s].present? do
      exp = params['numer_exp'+id.to_s]
      data = get_def_data(id, 'numer', params, log_id)
      numer_set.store("#{id}", {'explanation' => exp, 'data' => data})
      id += 1
    end
    numer_set

    set = {'def_denom' => denom_set, 'def_numer' => numer_set}
  end

  def get_def_data(id, type, params, log_id)
    if params[type+'_csv_form'+id.to_s].present? && params[type+'_csv_form'+id.to_s][0] == "yes"
      Definition.where(soft_delete: false).where(log_id: log_id).first.definitions['def_'+type][id.to_s]['data']
    else
      get_csv_data(params[type+'_file'+id.to_s])
    end
  end

  def get_csv_data(file)
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
    index = params['project'].to_s + \
    params['year'].to_s + \
    params['number'].to_s + \
    params['group'].to_s + \
    params['name'].to_s + \
    params['meaning'].to_s + \
    get_datasets(params).join.to_s + \
    params['numer'].to_s + \
    params['denom'].to_s + \
    get_definitions(params, self.log_id).values.join.to_s + \
    params['definition_detail'].to_s + \
    params['method_explanation'].to_s + \
    params['method_unit'].to_s + \
    params['warning'].to_s + \
    params['standard_value'].to_s + \
    get_references(params).to_s + \
    params['review_span'].to_s + \
    Time.now.to_s
  end

  def create_log_id(params)
    params['log_id'].blank? ? Definition.all.size : params['log_id'].to_i
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

  def self.search(params)
    results = Definition.where('soft_delete' => false).any_of({ :search_index => /#{params}/ }).to_a
  end

end
