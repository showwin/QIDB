json.set! :shops do
  json.array! @depts do |d|
    json.dept_id d.dept_id
    json.dept_kind_cd d.dept_kind_cd
    json.type d.type
    json.dept_name d.dept_name
    json.dept_zip_cd d.dept_zip_cd
    json.dept_address1 d.dept_address1
    json.dept_address2 d.dept_address2.nil? ? '' :  d.dept_address2
    json.dept_location d.dept_location
    json.dept_tel d.dept_tel
    json.dept_fd d.dept_fd.nil? ? '' : d.dept_fd
    json.dept_fax d.dept_fax
    json.dept_profile d.dept_profile
    json.opening_time d.opening_time
    json.closing_time d.closing_time
    json.dept_prefecture_cd d.dept_prefecture_cd
    json.prefecture_name d.prefecture_name
    json.latitude d.dept_detail.nil? ? '' :  d.dept_detail.latitude
    json.longitude d.dept_detail.nil? ? '' : d.dept_detail.longitude
    json.holiday_date1 d.holiday_date1
    json.holiday_date2 d.holiday_date2
    json.holiday_month1 d.holiday_month1
    json.holiday_day1 d.holiday_day1
    json.holiday_month2 d.holiday_month2
    json.holiday_day2 d.holiday_day2
    json.img_path_thmnl d.dept_detail.nil? ? '' : d.dept_detail.img_path_thmnl
    json.blog_url d.blog_url(@yaml_data)
    json.coupon_url d.coupon_url
    json.display_coupon_flg d.display_coupon_flg(@yaml_data)
    json.detail_url ''
    json.open_date d.open_date
    json.new_open d.new_open?
    json.shortly_open d.shortly_open?
  end
end
json.status 200
json.message 'OK'
