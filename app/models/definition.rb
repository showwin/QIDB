# Definition Model
class Definition
  require 'csv'

  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  scope :search_by_prjt_and_id, lambda { |params|
    return if params[:project].blank?
    if params[:id].present?
      # 機関と指標番号が指定されている場合
      where("numbers.#{params[:project]}" => params[:id])
    else
      # 特定の機関の全ての定義書を返す場合
      ne("numbers.#{params[:project]}" => nil)
    end
  }

  scope :active, lambda {
    where(soft_delete: false)
  }

  def find_duplicates
    PROJECT_NAMES.each_with_object([]) do |prjt, dups|
      next if numbers[prjt].blank?
      bup = Definition.active.where("numbers.#{prjt}" => numbers[prjt]).first
      dups << [prjt, dup.numbers[prjt]] if bup.present?
    end
  end

  def remove_duplicate
    PROJECT_NAMES.each do |prjt|
      next if numbers[prjt].blank?
      dups = Definition.active.where("numbers.#{prjt}" => numbers[prjt])
      dups.map(&:save_draft!) if dups.present?
    end
  end

  def make_public
    remove_duplicate
    self.soft_delete = false
    self.save!

    log = ChangeLog.where(_id: _id).last
    log.make_public if log.present?
  end

  def save_with_log!(editor, message)
    self.save!

    log = ChangeLog.new
    log.set_params(editor, message, _id, log_id)
    log.save!
  end

  def save_draft_with_log!(editor, message)
    self.save_draft!

    log = ChangeLog.new
    log.set_params(editor, message, _id, log_id)
    log.save_draft!
  end

  def save_draft!
    self.soft_delete = true
    self.save!
  end

  class << self
    def init_params(params)
      d = Definition.new
      param_list = %w(log_id numbers years group name meaning dataset def_summary
                      definitions drug_output def_risks method order annotation
                      standard_value references review_span indicator created_at
                      search_index soft_delete)
      param_list.each do |name|
        d[name] = eval("params.#{name}")
      end
      d
    end

    def search(keywords)
      results = Definition.active
      keywords.each do |keyword|
        results = results.and(search_index: /#{keyword}/)
      end
      results.to_a
    end

    def read_csv(file)
      fail "Unknown file type: #{file.original_filename}" unless \
        (File.extname(file.original_filename) == '.csv')
      csv = CSV.read(file.path)
      columns = csv[0].each_with_object([]) do |key, c|
        c << key
      end

      1.upto(csv.length - 1).each do |row_num|
        definition = Definition.new
        definition['def_summary'] = {}
        definition['numbers'] = {}
        definition['drug_output'] = false
        definition['order'] = 'asc'

        csv[row_num].each_with_index do |value, index|
          case columns[index]
          when '指標群'
            definition['group'] = value
          when '定義書表題'
            definition['name'] = value
          when '分母'
            definition['def_summary']['denom'] = value
          when '分子'
            definition['def_summary']['numer'] = value
          when '意義'
            definition['meaning'] = value
          else
            # 各プロジェクト
            definitions['numbers']["#{columns[index]}"] = value
          end
        end

        definition.make_public
      end
    end
  end
end
