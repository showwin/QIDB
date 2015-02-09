class ChangeLog
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  def set_params(params)
    self['指標番号'] = params['number']
    self['変更者'] = params['editor']
    self['変更メッセージ'] = params['edit_message']
    self['変更日時'] = Date.today.to_s
  end

end
