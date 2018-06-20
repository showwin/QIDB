class ChangeLog
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  def set_params(editor, message, _id, log_id)
    # _id: 特定の定義書で付けられたログを判断するため
    # log_id: 定義書の変化を追うため
    self.id = _id
    self['log_id'] = log_id
    self['editor'] = editor
    self['message'] = message
    self['created_at'] = Time.zone.today.to_s
    self['soft_delete'] = false
  end

  def make_public
    self.soft_delete = false
    self.save!
  end

  def save_draft!
    self.soft_delete = true
    self.save!
  end
end
