require 'csv'
CSV.generate(row_sep: "\r\n") do |csv|
  @contents.each do |content|
    content = content.map {|elem| NKF.nkf("-s",elem) if elem.kind_of?(String)}
    csv << content
  end
end
