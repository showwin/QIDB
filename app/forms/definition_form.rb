# DefinitionForm Class
class DefinitionForm
  attr_reader :log_id, :numbers, :years, :group, :group_en, :index, :name,
              :name_en, :meaning, :dataset, :def_summary, :def_summary_en,
              :definitions, :drug_output, :def_risks, :method, :order, :annotation,
              :standard_value, :references, :review_span, :indicator, :created_at,
              :search_index, :soft_delete, :duplicate_flg

  def initialize(params = [])
    @params = params
    @log_id = log_id
    @numbers = numbers
    @years = years
    @group = @params['group']
    @group_en = @params['group_en']
    @index = @params['index']
    @name = @params['name']
    @name_en = @params['name_en']
    @meaning = @params['meaning']
    @dataset = datasets
    @def_summary = { 'numer' => @params['numer'], 'denom' => @params['denom'] }
    @def_summary_en = { 'numer_en' => @params['numer_en'], 'denom_en' => @params['denom_en'] }
    @definitions = { 'def_denom' => def_denom, 'def_numer' => def_numer }
    @drug_output = @params['drug_output'][0] == 'yes' ? true : false
    @def_risks = def_risks
    @method = { 'explanation' => @params['method_explanation'], 'unit' => @params['method_unit'] }
    @order = @params['order'][0]
    @annotation = annotation
    @standard_value = standard_value
    @references = references
    @review_span = @params['review_span']
    @indicator = @params['indicator']
    @created_at = Time.zone.now.strftime('%Y-%m-%d')
    @search_index = search_index
    @soft_delete = false
    @duplicate_flg = params[:duplicate_flg] == 'true'
  end

  def log_id
    @params['log_id'].blank? ? Definition.count : @params['log_id'].to_i
  end

  def numbers
    PROJECT_NAMES.each_with_object({}) do |prjt, result|
      number = @params['project_' + prjt + '_number']
      result[prjt] = number if number.present?
    end
  end

  def years
    YEAR_OPTIONS.each_with_object([]) do |opt, result|
      result << opt if @params['year_' + opt] == 'true'
    end
  end

  def datasets
    set = []
    0.upto(4) do |i|
      set << @params["dataset_#{i}"]
      set << @params["dataset_others_#{i}"]
    end
    set.compact
  end

  def def_denom
    id = 1
    def_denom = {}
    while @params["denom_exp#{id}"].present?
      def_denom.store("#{id}", 'explanation' => @params["denom_exp#{id}"],
                               'data' => def_data(id, 'denom', 'denom'),
                               'filename' => def_data_fileaname(id, 'denom', 'denom'))
      id += 1
    end
    def_denom
  end

  def def_numer
    id = 1
    def_numer = {}
    while @params["numer_exp#{id}"].present?
      def_numer.store("#{id}", 'explanation' => @params["numer_exp#{id}"],
                               'data' => def_data(id, 'numer', 'numer'),
                               'filename' => def_data_fileaname(id, 'numer', 'numer'))
      id += 1
    end
    def_numer
  end

  def def_risks
    id = 1
    def_risks = {}
    while @params["risk_exp#{id}"].present?
      def_risks.store("#{id}", 'explanation' => @params["risk_exp#{id}"],
                               'data' => def_data(id, 'def_risks', 'risk'),
                               'filename' => def_data_fileaname(id, 'def_risks', 'risk'))
      id += 1
    end
    def_risks
  end

  def annotation
    id = 1
    annotation = {}
    while @params["anno_exp#{id}"].present?
      annotation.store("#{id}", 'explanation' => @params["anno_exp#{id}"],
                                'data' => def_data(id, 'annotation', 'anno'),
                                'filename' => def_data_fileaname(id, 'annotation', 'anno'))
      id += 1
    end
    annotation
  end

  def standard_value
    id = 1
    standard_value = {}
    while @params["ref_val_exp#{id}"].present?
      standard_value.store("#{id}", 'explanation' => @params["ref_val_exp#{id}"],
                                    'data' => def_data(id, 'standard_value', 'ref_val'),
                                    'filename' => def_data_fileaname(id, 'standard_value', 'ref_val'))
      id += 1
    end
    standard_value
  end

  def references
    id = 1
    references = {}
    while @params["ref_info_exp#{id}"].present?
      references.store("#{id}", 'explanation' => @params["ref_info_exp#{id}"],
                                'data' => def_data(id, 'references', 'ref_info'),
                                'filename' => def_data_fileaname(id, 'references', 'ref_info'))
      id += 1
    end
    references
  end

  def def_data(id, column, form)
    if @params["#{form}_csv_form#{id}"].present? &&
       @params["#{form}_csv_form#{id}"][0] == 'yes'
      # すでにDBに入ってるものを持ってくる
      fetch_saved_data(id, column, 'data')
    else
      # アップロードされたCSVからデータを取得
      read_csv_data(@params["#{form}_file#{id}"])
    end
  end

  def def_data_fileaname(id, column, form)
    if @params["#{form}_csv_form#{id}"].present? &&
       @params["#{form}_csv_form#{id}"][0] == 'yes'
      # すでにDBに入ってるものを持ってくる
      fetch_saved_data(id, column, 'filename')
    else
      # アップロードされたCSVからデータを取得
      read_csv_filename(@params["#{form}_file#{id}"])
    end
  end

  def fetch_saved_data(id, column, type)
    d = Definition.active.where(log_id: @log_id).first
    if column == 'denom' || column == 'numer'
      return d.definitions["def_#{column}"]["#{id}"]["#{type}"]
    else
      return eval("d.#{column}['#{id}']['#{type}']")
    end
  end

  def read_csv_data(file)
    return [] unless file
    fail "Unknown file type: #{file.original_filename}" unless \
      (File.extname(file.original_filename) == '.csv')
    csv = CSV.read(file.path, 'rt:cp932:utf-8')
    data = csv[0].each_with_object([]) do |key, d|
      d << { key => [] }
    end
    1.upto(csv.length - 1).each do |row_num|
      csv[row_num].each_with_index do |value, index|
        data[index][data[index].keys[0]] << value
      end
    end
    data
  end

  def read_csv_filename(file)
    return nil unless file
    fail "Unknown file type: #{file.original_filename}" unless \
      (File.extname(file.original_filename) == '.csv')
    file.original_filename
  end

  def search_index
    @numbers.to_s + \
      @years.to_s + \
      @group.to_s + \
      @name.to_s + \
      @meaning.to_s + \
      datasets.join.to_s + \
      @def_summary.to_s + \
      def_denom.values.join.to_s + \
      def_numer.values.join.to_s + \
      @def_risks.to_s + \
      @method.to_s + \
      @annotation.to_s + \
      @standard_value.to_s + \
      @references.to_s + \
      @review_span.to_s + \
      @indicator.to_s + \
      @created_at.to_s
  end
end
