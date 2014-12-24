class StringData
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  def self.create_record(id, sdata)
    data = StringData.new
    data['指標番号'] = id
    data['data'] = sdata
    data.save
  end

  def self.search(params)
    results = StringData.any_of({ :data => /#{params}/ }).to_a
    ids = []
    results.each do |r|
      ids << r['指標番号']
    end
    Definition.any_in({'指標番号' => ids}).to_a
  end
end
