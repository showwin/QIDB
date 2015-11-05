require 'csv'
CSV.generate(row_sep: "\r\n") do |csv|
  csv << CSV_COLUMNS
  @contents.each do |content|
    csv << content
  end
end.encode(Encoding::SJIS)
