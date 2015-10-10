require 'rails_helper'

RSpec.describe 'Definitions', type: :request do
  before(:each) do
    @d1 = create_definition
  end

  describe '#index' do
    it 'should return correct content' do
      l1 = create_change_log(editor: 'editor1', message: 'massage1', log_id: @d1.log_id)
      l2 = create_change_log(editor: 'editor2', message: 'massage2', log_id: @d1.log_id)
      get '/api/v1/definitions?id=64&project=qip'
      expect(response).to be_success
      expect(response.status).to eq(200)
      expect(response_json['status']).to eq(200)
      expect(response_json['message']).to eq('OK')
      expect(response_json['definitions'].size).to eq(1)
      definition = response_json['definitions'][0]
      expect(definition['projects'].size).to eq(2)
      expect([definition['projects'][0]['name'], definition['projects'][1]['name']].sort).to \
        eq(@d1.numbers.map(&:first).to_a.sort)
      expect([definition['projects'][0]['number'], definition['projects'][1]['number']].sort).to \
        eq(@d1.numbers.map(&:last).to_a.sort)
      expect(definition['years'].sort).to eq(@d1.years.sort)
      expect(definition['group']).to eq(@d1.group)
      expect(definition['name']).to eq(@d1.name)
      expect(definition['meaning']).to eq(@d1.meaning)
      expect(definition['dataset'].sort).to eq(@d1.dataset.sort)
      expect(definition['def_summary']['demon']).to eq(@d1.def_summary['denom'])
      expect(definition['def_summary']['numer']).to eq(@d1.def_summary['numer'])
      expect(definition['definitions']['denom']).to eq(@d1.definitions['def_denom'])
      expect(definition['definitions']['numer']).to eq(@d1.definitions['def_numer'])
      expect(definition['drug_output']).to eq(@d1.drug_output)
      expect(definition['def_risks']).to eq(@d1.def_risks)
      expect(definition['method']).to eq(@d1['method'])
      expect(definition['order']).to eq(@d1.order)
      expect(definition['notice']).to eq(@d1.annotation)
      expect(definition['standard_value']).to eq(@d1.standard_value)
      expect(definition['references']).to eq(@d1.references)
      expect(definition['review_span']).to eq(@d1.review_span)
      expect(definition['indicator']).to eq(@d1.indicator)
      expect(definition['created_at']).to eq(@d1.created_at)
      expect([definition['change_log'][0]['editor'], \
              definition['change_log'][1]['editor']].sort).to \
                eq([l1.editor, l2.editor].sort)
      expect([definition['change_log'][0]['message'], \
              definition['change_log'][1]['message']].sort).to \
                eq([l1.message, l2.message].sort)
    end

    it 'should return all definitions' do
      create_definition
      get '/api/v1/definitions?project=qip'
      expect(response).to be_success
      expect(response.status).to eq(200)
      expect(response_json['status']).to eq(200)
      expect(response_json['message']).to eq('OK')
      expect(response_json['definitions'].size).to eq(2)

      get '/api/v1/definitions'
      expect(response).to be_success
      expect(response.status).to eq(200)
      expect(response_json['status']).to eq(200)
      expect(response_json['message']).to eq('OK')
      expect(response_json['definitions'].size).to eq(2)
    end

    it 'should return 400' do
      get '/api/v1/definitions?id=1234'
      expect(response).to be_success
      expect(response.status).to eq(200)
      expect(response_json['status']).to eq(400)
      expect(response_json['message']).to eq('Invalid Parameters')
    end

    it 'should return 404' do
      get '/api/v1/definitions?project=abc'
      expect(response).to be_success
      expect(response.status).to eq(200)
      expect(response_json['status']).to eq(404)
      expect(response_json['message']).to eq('Not Found')
    end
  end
end
