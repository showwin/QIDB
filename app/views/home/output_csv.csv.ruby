require 'csv'
CSV.generate do |csv|
  csv << @column_names
  @contents.each do |content|
    csv << content
  end
end
