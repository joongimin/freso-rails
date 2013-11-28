task :check_access_token => :environment do
  crema ||= Mysql2::Client.new(host: 'nm-db1.the-nuvo.com', username: 'crema', password: 'qksksk123', database: 'crema')
  rows = crema.query('select * from sub_orders')
  rows_count = rows.count
  rows.each_with_index do |row, i|
    hash_key = row['review_widget_url'].gsub('http://fre.so/','')
    url = "http://sharecloset.co.kr/widgets/reviews/new?sub_order_id=#{row['id']}&access_token=#{row['access_token']}"
    url_v2 = url + "&review_source=30"
    route = Route.where(hash_key: hash_key).first
    if route
      if route.url != url && route.url != url_v2
        if route.url.include?('review_source=30')
          route.update_column(:url, url_v2)
        else
          route.update_column(:url, url)
        end
      end
    end
    print "\rCompleted #{i+1}/#{rows_count}"
  end
  puts ''
end