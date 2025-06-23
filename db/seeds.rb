puts "seedの実行を開始"

# 都道府県と代表市の対応表
prefecture_cities = {
  "北海道" => "札幌市", "青森県" => "青森市", "岩手県" => "盛岡市", "宮城県" => "仙台市", "秋田県" => "秋田市",
  "山形県" => "山形市", "福島県" => "福島市", "茨城県" => "水戸市", "栃木県" => "宇都宮市", "群馬県" => "前橋市",
  "埼玉県" => "さいたま市", "千葉県" => "千葉市", "東京都" => "新宿区", "神奈川県" => "横浜市",
  "新潟県" => "新潟市", "富山県" => "富山市", "石川県" => "金沢市", "福井県" => "福井市", "山梨県" => "甲府市",
  "長野県" => "長野市", "岐阜県" => "岐阜市", "静岡県" => "静岡市", "愛知県" => "名古屋市", "三重県" => "津市",
  "滋賀県" => "大津市", "京都府" => "京都市", "大阪府" => "大阪市", "兵庫県" => "神戸市",
  "奈良県" => "奈良市", "和歌山県" => "和歌山市", "鳥取県" => "鳥取市", "島根県" => "松江市",
  "岡山県" => "岡山市", "広島県" => "広島市", "山口県" => "山口市", "徳島県" => "徳島市",
  "香川県" => "高松市", "愛媛県" => "松山市", "高知県" => "高知市", "福岡県" => "福岡市",
  "佐賀県" => "佐賀市", "長崎県" => "長崎市", "熊本県" => "熊本市", "大分県" => "大分市",
  "宮崎県" => "宮崎市", "鹿児島県" => "鹿児島市", "沖縄県" => "那覇市"
}

# ユーザー作成
tarou = User.find_or_create_by!(email: "tarou@example.com") { |u| u.name = "太郎"; u.password = "password" }
hanako = User.find_or_create_by!(email: "hanako@example.com") { |u| u.name = "花子"; u.password = "password" }
shohei = User.find_or_create_by!(email: "shohei@example.com") { |u| u.name = "翔平"; u.password = "password" }

puts "PlaceおよびEventのデータ作成を開始"

prefecture_cities.each do |pref, city|
  code = JpPrefecture::Prefecture.find(name: pref)&.code
  next unless code

  Place.find_or_create_by!(name: "#{pref}のカフェ") do |place|
    place.prefecture_code = code
    place.city = city
    place.street = "中央1-1-1"
    place.zipcode = "1000000"
    place.description = "#{pref}にあるおしゃれなカフェです。"
  end

  Place.find_or_create_by!(name: "#{pref}の公園") do |place|
    place.prefecture_code = code
    place.city = city
    place.street = "緑町2-2-2"
    place.zipcode = "1000000"
    place.description = "#{pref}で子どもが遊べる広い公園です。"
  end
end

puts "都道府県ごとのPlaceデータの作成が完了しました"

place1 = Place.find_or_create_by!(name: "Shibuya Cafe") do |place|
  place.prefecture_code = 13
  place.city = "渋谷区"
  place.street = "神南1-1-1"
  place.zipcode = "1500041"
  place.description = "素晴らしいカフェで、美味しいコーヒーとケーキを提供しています。"
end

event1 = Event.find_or_create_by!(title: "Shibuya Workshop") do |event|
  event.body = "このワークショップでは、子供向けに色々なことが学べます。"
  event.start_date = Time.current
  event.end_date = Time.current + 3.hours
end

EventPlace.find_or_create_by!(place: place1, event: event1)

post1 = Post.find_or_create_by!(title: "Cavello") { |p| p.body = "大人気のカフェです。"; p.user = tarou; p.postable = place1 }
post2 = Post.find_or_create_by!(title: "和食屋 百花繚乱") { |p| p.body = "和食は美味しい！店内も広くて子供向けでした！"; p.user = hanako; p.postable = place1 }
post3 = Post.find_or_create_by!(title: "ShoreditchBar") { |p| p.body = "メキシコ料理好きにおすすめ！子供と行くには合わないかも。。"; p.user = shohei; p.postable = place1 }

tags = %w[子供向け 家族連れ カフェ 和食 バー].map { |name| Tag.find_or_create_by!(name: name) }

post1.tags << Tag.find_by(name: "カフェ")
post2.tags << Tag.find_by(name: "和食")
post3.tags << Tag.find_by(name: "バー")

review1 = Review.find_or_create_by!(score: 5, body: "本当に素晴らしいお店でした！") { |r| r.user = tarou; r.post = post1 }
review2 = Review.find_or_create_by!(score: 4, body: "また行きたいと思います！") { |r| r.user = hanako; r.post = post2 }
review3 = Review.find_or_create_by!(score: 3, body: "子供向けではなかったですが、味は美味しかったです。") { |r| r.user = shohei; r.post = post3 }

Comment.find_or_create_by!(body: "とても良いお店でした！また行きたいです。") { |c| c.user = tarou; c.commetable = post1 }
Comment.find_or_create_by!(body: "家族連れにはぴったりですね！") { |c| c.user = hanako; c.commetable = post2 }
Comment.find_or_create_by!(body: "味は良かったですが、ちょっと高いかも。") { |c| c.user = shohei; c.commetable = review1 }

puts "投稿に関連情報の追加が完了しました"

Admin.find_or_create_by!(email: "admin@example.com") do |admin|
  admin.password = "password"
  admin.password_confirmation = "password"
end

puts "管理者ユーザーの作成が完了しました"
puts "テストデータの作成が完了しました"