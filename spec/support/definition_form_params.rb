# use CreateDefinition Module to create mock instead of FactoryBot
module DefinitionFormParams
  def definition_form_params
    {
      'project_qip_number' => '123333',
      'name' => '名称',
      'drug_output' => ['no'],
      'order' => ['desc'],
      'editor' => '編集者',
      'message' => '編集メッセージ'
    }
  end
end

RSpec.configure do |config|
  config.include DefinitionFormParams
end
