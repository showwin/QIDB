require 'csv'
CSV.generate do |csv|
  csv << CSV_COLUMNS
  @contents.each do |content|
    csv << content
  end
end
