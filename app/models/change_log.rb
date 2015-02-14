class ChangeLog
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  def set_params(params, _id, log_id)
    # _id: 特定の定義書で付けられたログを判断するため
    # log_id: 定義書の変化を追うため
    self['id'] = _id
    self['log_id'] = log_id
    self['editor'] = params['editor']
    self['message'] = params['message']
    self['created_at'] = Date.today.to_s
    self['soft_delete'] = false
  end

  def tmp_save
    self['soft_delete'] = true
    self.save
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
