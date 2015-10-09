class Definition
  require 'csv'

  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  @@projects = ['qip', 'jha', 'jmha', 'sai', 'min', 'jma', 'ajha', 'nho', 'rofuku', 'jamcf']

  def find_duplicates
    dups = []
    @@projects.each do |prjt|
      next if self.numbers[prjt].blank?
      bup = Definition.where(soft_delete: false)
                      .where("numbers.#{prjt}" => self.numbers[prjt]).first
      if bup.present?
        dups << [prjt, dup.numbers[prjt]]
      end
    end
    dups
  end

  def remove_duplicate
    @@projects.each do |prjt|
      next if self.numbers[prjt].blank?
      dups = Definition.where(soft_delete: false)
                       .where("numbers.#{prjt}" => self.numbers[prjt])
      if dups.present?
        dups.each do |dup|
          dup.soft_delete = true
          raise if !dup.save
        end
      end
    end
  end

  def tmp_save
    self.soft_delete = true
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
    self['def_risks'] = get_def_risk(params)
    self['method'] = { 'explanation' => params['method_explanation'], 'unit' => params['method_unit'] }
    self['order'] = params['order'][0]
    self['annotation'] = get_def_anno(params)
    self['standard_value'] = get_def_ref_val(params)
    self['references'] = get_def_ref_info(params)
    self['review_span'] = params['review_span']
    self['indicator'] = params['indicator']
    self['created_at'] = Time.now.strftime('%Y-%m-%d')
    self['search_index'] = create_search_index(params)
    self['soft_delete'] = false
  end

  def get_numbers(params)
    result = {}
    @@projects.each do |prjt|
      number = params['project_'+prjt+'_number']
      if number.present?
        result[prjt] = number
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

  def get_definitions(params, log_id)
    #分母 denom
    id = 1
    denom_set = {}
    while params['denom_exp'+id.to_s].present? do
      exp = params['denom_exp'+id.to_s]
      data,filename = get_def_data(id, 'denom', params, log_id)
      denom_set.store("#{id}", {'explanation' => exp, 'data' => data, 'filename' => filename})
      id += 1
    end
    denom_set

    #分子 numer
    id = 1
    numer_set = {}
    while params['numer_exp'+id.to_s].present? do
      exp = params['numer_exp'+id.to_s]
      data,filename = get_def_data(id, 'numer', params, log_id)
      numer_set.store("#{id}", {'explanation' => exp, 'data' => data, 'filename' => filename})
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
      data,filename = get_def_data(id, 'risk', params, log_id)
      risk_set.store("#{id}", {'explanation' => exp, 'data' => data, 'filename' => filename})
      id += 1
    end
    risk_set
  end

  def get_def_anno(params)
    id = 1
    anno_set = {}
    while params['anno_exp'+id.to_s].present? do
      exp = params['anno_exp'+id.to_s]
      data,filename = get_def_data(id, 'anno', params, log_id)
      anno_set.store("#{id}", {'explanation' => exp, 'data' => data, 'filename' => filename})
      id += 1
    end
    anno_set
  end

  def get_def_ref_val(params)
    id = 1
    ref_val_set = {}
    while params['ref_val_exp'+id.to_s].present? do
      exp = params['ref_val_exp'+id.to_s]
      data,filename = get_def_data(id, 'ref_val', params, log_id)
      ref_val_set.store("#{id}", {'explanation' => exp, 'data' => data, 'filename' => filename})
      id += 1
    end
    ref_val_set
  end

  def get_def_ref_info(params)
    id = 1
    ref_info_set = {}
    while params['ref_info_exp'+id.to_s].present? do
      exp = params['ref_info_exp'+id.to_s]
      data,filename = get_def_data(id, 'ref_info', params, log_id)
      ref_info_set.store("#{id}", {'explanation' => exp, 'data' => data, 'filename' => filename})
      id += 1
    end
    ref_info_set
  end

  def get_def_data(id, type, params, log_id)
    if params[type+'_csv_form'+id.to_s].present? && params[type+'_csv_form'+id.to_s][0] == "yes"
      # すでにDBに入ってるものを持ってくる
      if type == 'denom' || type == 'numer'
        return Definition.where(soft_delete: false).where(log_id: log_id).first.definitions['def_'+type][id.to_s]['data'],Definition.where(soft_delete: false).where(log_id: log_id).first.definitions['def_'+type][id.to_s]['filename']
      elsif type == 'risk'
        return Definition.where(soft_delete: false).where(log_id: log_id).first.def_risks[id.to_s]['data'],Definition.where(soft_delete: false).where(log_id: log_id).first.def_risks[id.to_s]['filename']
      elsif type == 'anno'
        return Definition.where(soft_delete: false).where(log_id: log_id).first.annotation[id.to_s]['data'],Definition.where(soft_delete: false).where(log_id: log_id).first.annotation[id.to_s]['filename']
      elsif type == 'ref_val'
        return Definition.where(soft_delete: false).where(log_id: log_id).first.standard_value[id.to_s]['data'],Definition.where(soft_delete: false).where(log_id: log_id).first.standard_value[id.to_s]['filename']
      elsif type == 'ref_info'
        return Definition.where(soft_delete: false).where(log_id: log_id).first.references[id.to_s]['data'],Definition.where(soft_delete: false).where(log_id: log_id).first.references[id.to_s]['filename']
      end
    else
      # アップロードされたCSVからデータを取得
      get_csv_data(params[type+'_file'+id.to_s])
    end
  end

  def get_csv_data(file)
    return [] if !file
    raise "Unknown file type: #{file.original_filename}" if !(File.extname(file.original_filename) == '.csv')
    csv = CSV.read(file.path)
    filename = file.original_filename
    data = []
    csv[0].each do |key|
      data << {key => []}
    end
    1.upto(csv.length-1).each do |row_num|
      csv[row_num].each_with_index do |value, index|
        data[index][data[index].keys[0]] << value
      end
    end
    return data,filename
  end

  def create_search_index(params)
    numbers = ""
    @@projects.each do |prjt|
      numbers += prjt+params['project_'+prjt+'_number'] if params['project_'+prjt+'_number']
    end
    index =
      numbers + \
      params['year'].to_s + \
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
      get_def_ref_info(params).to_s + \
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
        when "qip"
          params['project_qip_number'] = value
        when "jha"
          params['project_jha_number'] = value
        when "jmha"
          params['project_jmha_number'] = value
        when "sai"
          params['project_sai_number'] = value
        when "min"
          params['project_min_number'] = value
        when "jma"
          params['project_jma_number'] = value
        when "ajha"
          params['project_ajha_number'] = value
        when "nho"
          params['project_nho_number'] = value
        when "rofuku"
          params['project_rofuku_number'] = value
        when "jamcf"
          params['project_jamcf_number'] = value
        when "指標群"
          params['group'] = value
        when "定義書表題"
          params['name'] = value
        when "分母"
          params['denom'] = value
        when "分子"
          params['numer'] = value
        when "意義"
          params['meaning'] = value
        end
      end

      params['drug_output'] = []
      params['drug_output'][0] = false
      params['order'] = []
      params['order'][0] = 'asc'

      @definition.set_params(params)

      @definition.remove_duplicate
      if !@definition.save
        flag = false
      end

    end
    return flag
  end

  def self.search(keywords)
    results = Definition.where('soft_delete' => false)
    keywords.each do |keyword|
      results = results.and(search_index: /#{keyword}/)
    end
    results.to_a
  end

end
