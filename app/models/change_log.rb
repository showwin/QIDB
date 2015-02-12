class ChangeLog
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  def set_params(params, id)
    self['id'] = id
    self['editor'] = params['editor']
    self['message'] = params['message']
    self['created_at'] = Date.today.to_s
  end

  def self.make_json(id)
    logs = ChangeLog.where(指標番号: id)
    result = []
    logs.each do |log|
      result << log
    end
    result
  end
end
