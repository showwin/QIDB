require 'rails_helper'

RSpec.describe ChangeLog, type: :model do
  it 'should create change log' do
    expect(ChangeLog.all.count).to eq(0)
    create_change_log(editor: 'editor1', message: 'message1')
    c = ChangeLog.last
    expect(ChangeLog.all.count).to eq(1)
    expect(c.editor).to eq('editor1')
    expect(c.message).to eq('message1')
  end

  describe '#set_params' do
    it 'should init params' do
      cl = ChangeLog.new
      editor = 'editor1'
      message = 'message1'
      cl.set_params(editor, message, 1, 2)
      expect(cl._id).to eq(1)
      expect(cl.log_id).to eq(2)
      expect(cl.editor).to eq(editor)
      expect(cl.message).to eq(message)
      expect(cl.created_at).to eq(Time.zone.today.to_s)
      expect(cl.soft_delete).to be_falsey
    end
  end

  describe '#tmp_save' do
    it 'should change soft_delete true' do
      cl = create_change_log(editor: 'editor1', message: 'message1')
      expect(cl.soft_delete).to be_falsey
      cl.tmp_save!
      expect(cl.soft_delete).to be_truthy
    end
  end

  describe '#make_json' do
    it 'should return array of log list' do
      create_change_log(log_id: 1)
      create_change_log(log_id: 1)
      cls = ChangeLog.make_json(1)
      expect(cls).to eq(ChangeLog.where(log_id: 1).to_a)
    end
  end
end
