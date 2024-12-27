puts "seedの実行を開始"

olivia = User.find_or_create_by!(email: "olivia@example.com") do |user|
  user.name = "Olivia"
  user.password = "password"
end

james = User.find_or_create_by!(email: "james@example.com") do |user|
  user.name = "James"
  user.password = "password"
end

lucas = User.find_or_create_by!(email: "lucas@example.com") do |user|
  user.name = "Lucas"
  user.password = "password"
end

Post.find_or_create_by!(title: "Cavello") do |post|
  post.body = "大人気のカフェです。"
  post.user = olivia
end

Post.find_or_create_by!(title: "和食屋 百花繚乱") do |post|
  post.body = "和食は美味しい！店内も広くて子供向けでした！"
  post.user = james
end

Post.find_or_create_by!(title: "ShoreditchBar") do |post|
  post.body = "メキシコ料理好きにおすすめ！子供と行くには合わないかも。。"
  post.user = lucas
end

# コメントデータ
post1 = Post.find_by(title: "Cavello")
post2 = Post.find_by(title: "和食屋 百花繚乱")
post3 = Post.find_by(title: "ShoreditchBar")

Comment.find_or_create_by!(body: "とても良いお店でした！また行きたいです。") do |comment|
  comment.user = User.find_by(name: "Olivia")
  comment.commetable = post1
end

Comment.find_or_create_by!(body: "家族連れにはぴったりですね！") do |comment|
  comment.user = User.find_by(name: "James")
  comment.commetable = post2
end

Comment.find_or_create_by!(body: "味は良かったですが、ちょっと高いかも。") do |comment|
  comment.user = User.find_by(name: "Lucas")
  comment.commetable = post3
end

# タグデータ
Tag.find_or_create_by!(name: "子供向け")
Tag.find_or_create_by!(name: "家族連れ")
Tag.find_or_create_by!(name: "カフェ")
Tag.find_or_create_by!(name: "和食")
Tag.find_or_create_by!(name: "バー")

# Postにタグを追加
post1.tags << Tag.find_by(name: "カフェ")
post2.tags << Tag.find_by(name: "和食")
post3.tags << Tag.find_by(name: "バー")

# レビューの追加
Review.find_or_create_by!(score: 5, body: "本当に素晴らしいお店でした！") do |review|
  review.user = User.find_by(name: "Olivia")
  review.post = post1
end

Review.find_or_create_by!(score: 4, body: "また行きたいと思います！") do |review|
  review.user = User.find_by(name: "James")
  review.post = post2
end

Review.find_or_create_by!(score: 3, body: "子供向けではなかったですが、味は美味しかったです。") do |review|
  review.user = User.find_by(name: "Lucas")
  review.post = post3
end

puts "PlaceおよびEventのデータ作成を開始"

# Placeデータ作成
place = Place.find_or_create_by!(name: "Shoreditch Cafe") do |place|
  place.address = "ロンドン, Shoreditch 123"
  place.description = "素晴らしいカフェで、美味しいコーヒーとケーキを提供しています。"
end

# Eventデータ作成
event = Event.find_or_create_by!(title: "Shoreditch Workshop") do |event|
  event.body = "このワークショップでは、デザインの基本を学べます。"
  event.start_date = Time.now
  event.end_date = Time.now + 3.hours
end

puts "PlaceおよびEventのデータ作成が完了しました"

puts "投稿に関連情報を追加"

# 投稿を作成
post1 = Post.find_by(title: "Cavello")

# 投稿にPlace情報を関連付け
post1.update(postable: place)

# 他の投稿にはEventを関連付ける
post2 = Post.find_by(title: "和食屋 百花繚乱")
post2.update(postable: event)

puts "投稿に関連情報の追加が完了しました"
puts "管理者ユーザーの作成を開始"

# 管理者ユーザーの作成
admin_user = User.find_or_create_by!(email: "admin@example.com") do |user|
  user.name = "Admin"
  user.password = "password"
  user.admin = true  # 管理者権限を付与
end

puts "管理者ユーザーの作成が完了しました"
puts "テストデータの作成が完了しました"