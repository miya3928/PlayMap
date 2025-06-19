puts "seedの実行を開始"

# ユーザー作成
tarou = User.find_or_create_by!(email: "tarou@example.com") do |user|
  user.name = "太郎"
  user.password = "password"
end

hanako = User.find_or_create_by!(email: "hanako@example.com") do |user|
  user.name = "花子"
  user.password = "password"
end

shohei = User.find_or_create_by!(email: "shohei@example.com") do |user|
  user.name = "翔平"
  user.password = "password"
end

puts "PlaceおよびEventのデータ作成を開始"

puts "都道府県ごとのPlaceデータを作成"

prefectures = %w[
  北海道 青森県 岩手県 宮城県 秋田県 山形県 福島県
  茨城県 栃木県 群馬県 埼玉県 千葉県 東京都 神奈川県
  新潟県 富山県 石川県 福井県 山梨県 長野県
  岐阜県 静岡県 愛知県 三重県
  滋賀県 京都府 大阪府 兵庫県 奈良県 和歌山県
  鳥取県 島根県 岡山県 広島県 山口県
  徳島県 香川県 愛媛県 高知県
  福岡県 佐賀県 長崎県 熊本県 大分県 宮崎県 鹿児島県 沖縄県
]

prefectures.each do |pref|
  code = JpPrefecture::Prefecture.find(name: pref).code

  Place.find_or_create_by!(name: "#{pref}のカフェ") do |place|
    place.prefecture_code = code
    place.city = "#{pref}市"
    place.street = "中央1-1-1"
    place.zipcode = "1000000"
    place.description = "#{pref}にあるおしゃれなカフェです。"
  end

  Place.find_or_create_by!(name: "#{pref}の公園") do |place|
    place.prefecture_code = code
    place.city = "#{pref}市"
    place.street = "緑町2-2-2"
    place.zipcode = "1000000"
    place.description = "#{pref}で子どもが遊べる広い公園です。"
  end
end

puts "都道府県ごとのPlaceデータの作成が完了しました"
# Place1（Shibuya Cafe）
place1 = Place.find_or_create_by!(name: "Shibuya Cafe") do |place|
  place.prefecture_code = 13  # 東京都
  place.city = "渋谷区"
  place.street = "神南1-1-1"
  place.zipcode = "1500041"
  place.description = "素晴らしいカフェで、美味しいコーヒーとケーキを提供しています。"
end

# Event1（Shibuya Workshop）
event1 = Event.find_or_create_by!(title: "Shibuya Workshop") do |event|
  event.body = "このワークショップでは、子供向けに色々なことが学べます。"
  event.start_date = Time.current
  event.end_date = Time.current + 3.hours
end

# 中間テーブル登録
EventPlace.find_or_create_by!(place: place1, event: event1)

# 投稿データ
post1 = Post.find_or_create_by!(title: "Cavello") do |post|
  post.body = "大人気のカフェです。"
  post.user = tarou
  post.postable = place1
end

post2 = Post.find_or_create_by!(title: "和食屋 百花繚乱") do |post|
  post.body = "和食は美味しい！店内も広くて子供向けでした！"
  post.user = hanako
  post.postable = place1
end

post3 = Post.find_or_create_by!(title: "ShoreditchBar") do |post|
  post.body = "メキシコ料理好きにおすすめ！子供と行くには合わないかも。。"
  post.user = shohei
  post.postable = place1
end

# タグ作成
tags = %w[子供向け 家族連れ カフェ 和食 バー].map do |name|
  Tag.find_or_create_by!(name: name)
end

# タグ関連付け
post1.tags << Tag.find_by(name: "カフェ")
post2.tags << Tag.find_by(name: "和食")
post3.tags << Tag.find_by(name: "バー")

# レビュー
review1 = Review.find_or_create_by!(score: 5, body: "本当に素晴らしいお店でした！") do |review|
  review.user = tarou
  review.post = post1
end

review2 = Review.find_or_create_by!(score: 4, body: "また行きたいと思います！") do |review|
  review.user = hanako
  review.post = post2
end

review3 = Review.find_or_create_by!(score: 3, body: "子供向けではなかったですが、味は美味しかったです。") do |review|
  review.user = shohei
  review.post = post3
end

# コメント
Comment.find_or_create_by!(body: "とても良いお店でした！また行きたいです。") do |comment|
  comment.user = tarou
  comment.commetable = post1
end

Comment.find_or_create_by!(body: "家族連れにはぴったりですね！") do |comment|
  comment.user = hanako
  comment.commetable = post2
end

Comment.find_or_create_by!(body: "味は良かったですが、ちょっと高いかも。") do |comment|
  comment.user = shohei
  comment.commetable = review1
end

puts "投稿に関連情報の追加が完了しました"

# 管理者ユーザー
admin = Admin.find_or_create_by!(email: "admin@example.com") do |admin|
  admin.password = "password"
  admin.password_confirmation = "password"
end

puts "管理者ユーザーの作成が完了しました"
puts "テストデータの作成が完了しました"