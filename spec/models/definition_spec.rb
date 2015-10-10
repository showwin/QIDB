require 'rails_helper'

RSpec.describe Definition, type: :model do
  it 'should create definition' do
    expect(Definition.all.count).to eq(0)
    create_definition
    d = Definition.last
    expect(d.group).to eq('呼吸器系')
    expect(Definition.all.count).to eq(1)
  end

  describe '#find_duplicates' do
    it 'should return array of duplicated list' do
      create_definition
      d = create_definition
      expect(d.find_duplicates).to eq([%w(qip 64), %w(jha 2)])
    end
  end

  describe '#remove_duplicate' do
    it 'should soft delete duplicated definition' do
      d_org = create_definition
      expect(d_org.soft_delete).to be_falsey
      d = create_definition
      d.remove_duplicate
      # refresh d_org params
      d_org = Definition.first
      expect(d_org.soft_delete).to be_truthy
    end
  end

  describe '#make_public' do
    it 'should not soft deleted' do
      d = create_definition
      d.soft_delete = true
      d.save
      expect(d.soft_delete).to be_truthy
      d.make_public
      expect(d.soft_delete).to be_falsey
    end

    it 'should delete duplicate definition' do
      d1 = create_definition
      expect(d1.soft_delete).to be_falsey
      d2 = create_definition
      d2.make_public
      d1 = Definition.first
      expect(d1.soft_delete).to be_truthy
      expect(d2.soft_delete).to be_falsey
    end

    it 'should make log public' do
      d = create_definition
      d.save_draft_with_log!('editor', 'message')
      expect(ChangeLog.first.soft_delete).to be_truthy
      expect(Definition.first.soft_delete).to be_truthy
      d.make_public
      expect(ChangeLog.first.soft_delete).to be_falsey
      expect(Definition.first.soft_delete).to be_falsey
    end
  end

  describe '#save_with_log' do
    it 'should create log' do
      expect(ChangeLog.all.size).to eq(0)
      d = create_definition
      d.save_with_log!('editor1', 'message1')
      expect(Definition.first.soft_delete).to be_falsey
      expect(ChangeLog.all.size).to eq(1)
      log = ChangeLog.first
      expect(log.soft_delete).to be_falsey
      expect(log.editor).to eq('editor1')
      expect(log.message).to eq('message1')
    end
  end

  describe '#save_draft_with_log' do
    it 'should create log draft' do
      expect(ChangeLog.all.size).to eq(0)
      d = create_definition
      d.save_draft_with_log!('editor1', 'message1')
      expect(Definition.first.soft_delete).to be_truthy
      expect(ChangeLog.all.size).to eq(1)
      log = ChangeLog.first
      expect(log.soft_delete).to be_truthy
      expect(log.editor).to eq('editor1')
      expect(log.message).to eq('message1')
    end
  end

  describe '#save_draft!' do
    it 'should soft delete' do
      d_org = create_definition
      expect(d_org.soft_delete).to be_falsey
      d_org.save_draft!
      expect(d_org.soft_delete).to be_truthy
    end
  end

  describe '#read_csv' do
    # CSVの読み込みは features テストの方でカバー
  end

  describe '#search' do
    it 'should search coreectly' do
      create_definition
      result = Definition.search(%w(縦隔生検 呼吸器系))
      expect(result.size).to eq(1)
      expect(result[0].group).to eq('呼吸器系')
      result = Definition.search(%w(存在しない キーワード))
      expect(result.size).to eq(0)
    end
  end
end
