# use CreateDefinition Module to create mock instead of FactoryBot
module CreateChangeLog
  def create_change_log(params)
    params[:log_id] ||= '1'
    params[:editor] ||= 'test'
    params[:message] ||= 'edited'
    params[:created_at] ||= '2015-10-08'
    params[:soft_delete] ||= false
    @log = ChangeLog.new(params)
    @log.save
    @log
  end
end

RSpec.configure do |config|
  config.include CreateChangeLog
end
