# Seedデータの処理を高速化するため、一時的にバリデーションをスキップしたい場合は、
# 個々のモデルに `validates :column, presence: true` のような設定がないことを確認するか、
# `Model.create!(..., validate: false)` を検討してください（通常は非推奨）。
# ここでは、標準的な `create!` を使用します。

puts "--- Seeding Data Start ---"

# ----------------------------------------
# 1. Admins
# ----------------------------------------
Admin.find_or_create_by!(email: "admin@example.com") do |admin|
  admin.password = "password"
  admin.password_confirmation = "password"
end
puts "✅ Admin user created."

# ----------------------------------------
# 2. Users (10 users)
# ----------------------------------------
User.destroy_all
users = []
(1..10).each do |i|
  name = case i
         when 1 then "陽子"
         when 2 then "健太"
         else "ユーザー#{i}"
         end

  users << User.create!(
    email: "user#{i}@example.com",
    password: "password",
    password_confirmation: "password",
    name: name,
    introduction: "私は#{name}です。旅行とカフェ巡りが趣味です。",
    is_active: (i != 10)
  )
end

# 新しい変数名で参照
yoko = users[0] 
kenta = users[1] 
puts "✅ 10 Users created. (佐藤 陽子, 田中 健太...)"

# ... (Place, Event, Tagの作成は省略) ...

# ----------------------------------------
# 3. Places (10 places) - 子供向け実在の場所と正確な緯度経度
# ----------------------------------------
Place.destroy_all
places = []
# 1. 京都鉄道博物館
places << Place.create!(name: "京都鉄道博物館", address: "京都府京都市下京区", description: "SLから新幹線まで、実物の車両展示が楽しい。", latitude: 34.9877, longitude: 135.7505, zipcode: "600-8835", city: "京都市", street: "観喜寺町", prefecture_code: 26)

# 2. 新宿御苑
places << Place.create!(name: "新宿御苑", address: "東京都新宿区", description: "広大な芝生と庭園があり、ピクニックに最適。", latitude: 35.6852, longitude: 139.7101, zipcode: "160-0014", city: "新宿区", street: "内藤町", prefecture_code: 13)

# 3. 新江ノ島水族館
places << Place.create!(name: "新江ノ島水族館", address: "神奈川県藤沢市", description: "相模湾と富士山を背景に、イルカショーが楽しめる。", latitude: 35.3054, longitude: 139.4795, zipcode: "251-0035", city: "藤沢市", street: "片瀬海岸", prefecture_code: 14)

# 4. 大阪市立科学館
places << Place.create!(name: "大阪市立科学館", address: "大阪府大阪市北区", description: "プラネタリウムや体験型の展示が人気。", latitude: 34.6946, longitude: 135.4925, zipcode: "530-0005", city: "大阪市", street: "中之島", prefecture_code: 27)

# 5. 札幌円山動物園
places << Place.create!(name: "札幌円山動物園", address: "北海道札幌市中央区", description: "ホッキョクグマ館など、動物との距離が近い。", latitude: 43.0416, longitude: 141.2987, zipcode: "064-0959", city: "札幌市", street: "宮ヶ丘", prefecture_code: 1)

# 6. リニア・鉄道館
places << Place.create!(name: "リニア・鉄道館", address: "愛知県名古屋市港区", description: "日本の高速鉄道の技術を体験できる。", latitude: 35.0864, longitude: 136.8373, zipcode: "455-0848", city: "名古屋市", street: "金城ふ頭", prefecture_code: 23)

# 7. 福岡アンパンマンこどもミュージアムinモール
places << Place.create!(name: "福岡アンパンマンこどもミュージアムinモール", address: "福岡県福岡市博多区", description: "アンパンマンの世界で遊べる屋内施設。", latitude: 33.5937, longitude: 130.4124, zipcode: "812-0027", city: "福岡市", street: "下川端町", prefecture_code: 40)

# 8. 仙台うみの杜水族館
places << Place.create!(name: "仙台うみの杜水族館", address: "宮城県仙台市宮城野区", description: "三陸の豊かな海を再現。大迫力のイルカ・アシカショー。", latitude: 38.2578, longitude: 140.9576, zipcode: "983-0013", city: "仙台市", street: "中野", prefecture_code: 4)

# 9. 上野動物園
places << Place.create!(name: "上野動物園", address: "東京都台東区", description: "パンダや絶滅危惧種に会える、歴史ある動物園。", latitude: 35.7169, longitude: 139.7711, zipcode: "110-8717", city: "台東区", street: "上野公園", prefecture_code: 13)

# 10. 富士急ハイランド
places << Place.create!(name: "富士急ハイランド", address: "山梨県富士吉田市", description: "トーマスランドなど、小さな子供向けエリアも充実。", latitude: 35.7020, longitude: 138.7845, zipcode: "403-0017", city: "富士吉田市", street: "新西原", prefecture_code: 19)
puts "✅ 10 Places created. "
# ----------------------------------------
# 4. Events (10 events)
# ----------------------------------------
Event.destroy_all
events = []
events << Event.create!(title: "秋のグルメフェス", body: "全国の美味しいものが集まる食の祭典！", start_date: 1.week.from_now, end_date: 1.week.from_now + 2.days)
events << Event.create!(title: "星空観測会", body: "専門家の解説付きで、満天の星を楽しみます。", start_date: 3.weeks.from_now, end_date: 3.weeks.from_now + 3.hours)
events << Event.create!(title: "歴史講演会", body: "戦国時代の知られざるエピソードを紹介。", start_date: 5.weeks.from_now, end_date: 5.weeks.from_now + 1.hour)
events << Event.create!(title: "無料ITセミナー", body: "AI技術の最新動向について学べます。", start_date: 7.weeks.from_now, end_date: 7.weeks.from_now + 4.hours)
events << Event.create!(title: "クラフトビール祭り", body: "地元のクラフトビール醸造所が集結！", start_date: 9.weeks.from_now, end_date: 9.weeks.from_now + 1.day)
events << Event.create!(title: "写真展『日本の四季』", body: "四季折々の美しい日本の風景写真。", start_date: 11.weeks.from_now, end_date: 11.weeks.from_now + 1.month)
events << Event.create!(title: "ボランティア清掃活動", body: "海岸のゴミを拾う活動。環境保護に貢献。", start_date: 13.weeks.from_now, end_date: 13.weeks.from_now + 3.hours)
events << Event.create!(title: "地域のお祭り", body: "盆踊りや屋台が並ぶ、伝統的なお祭り。", start_date: 15.weeks.from_now, end_date: 15.weeks.from_now + 2.days)
events << Event.create!(title: "新刊サイン会", body: "人気作家による新刊のサイン会。", start_date: 17.weeks.from_now, end_date: 17.weeks.from_now + 2.hours)
events << Event.create!(title: "eスポーツ大会", body: "注目のeスポーツタイトルで熱い戦い。", start_date: 19.weeks.from_now, end_date: 19.weeks.from_now + 1.day)
puts "✅ 10 Events created."

# ----------------------------------------
# 5. EventPlaces (Linking Events and Places)
# ----------------------------------------
EventPlace.destroy_all
# イベントと場所を適当にリンク
EventPlace.create!(event: events[0], place: places[9]) # グルメフェス -> ワイナリー
EventPlace.create!(event: events[1], place: places[7]) # 星空観測会 -> 山頂展望台
EventPlace.create!(event: events[2], place: places[6]) # 歴史講演会 -> 歴史博物館
EventPlace.create!(event: events[3], place: places[3]) # ITセミナー -> テクノロジー施設
EventPlace.create!(event: events[4], place: places[2]) # ビール祭り -> 海の見えるカフェ（広場を想定）
EventPlace.create!(event: events[5], place: places[5]) # 写真展 -> アートギャラリー
EventPlace.create!(event: events[6], place: places[2]) # 清掃活動 -> 海の見えるカフェ（海岸を想定）
puts "✅ Event-Place links created."

# ----------------------------------------
# 6. Tags
# ----------------------------------------
Tag.destroy_all
tag_names = ["グルメ", "観光", "絶景", "歴史", "アウトドア", "カフェ", "アート", "イベント", "学び", "東京", "京都"]
tags = tag_names.map { |name| Tag.find_or_create_by!(name: name) }
puts "✅ Tags created."

# ----------------------------------------
# 7. Posts (20 posts)
# ----------------------------------------
Post.destroy_all
posts = []

# --- 画像添付用のヘルパーメソッド ---
# Active Storageによる添付ロジックを共通化
def attach_seed_image(record, filename)
  # 画像のパスを構築 (app/assets/images/seed_images/ から参照)
  path = Rails.root.join("app/assets/images/seed_images/#{filename}")
  
  # ファイルが存在するか確認し、存在する場合のみ添付処理を行う
  if File.exist?(path)
    # 適切な content_type を決定 (ファイル拡張子に基づいて判断)
    content_type = case File.extname(filename).downcase
                   when '.jpg', '.jpeg' then 'image/jpeg'
                   when '.png' then 'image/png'
                   when '.gif' then 'image/gif'
                   else 'application/octet-stream'
                   end
    
    record.image.attach(io: File.open(path), 
                        filename: filename, 
                        content_type: content_type)
    puts "   -> [画像添付成功] #{record.title}: #{filename}"
  else
    puts "   -> [画像添付スキップ] ファイルが見つかりません: #{filename}"
  end
end
# --------------------------------------

# 投稿 1: 京都鉄道博物館 (Place)
post1 = Post.create!(title: "京都・鉄道博物館は最高！", body: "新幹線とSLに大興奮！子供より親が楽しんだかも。", user: yoko, postable_type: "Place", postable_id: places[0].id)
attach_seed_image(post1, "railway_museum.jpg")
posts << post1

# 投稿 2: 新宿御苑 (Place)
post2 = Post.create!(title: "新宿御苑でピクニック日和", body: "都会のオアシスで広々遊べました。お弁当持参がおすすめ。", user: kenta, postable_type: "Place", postable_id: places[1].id)
attach_seed_image(post2, "shinjuku_park.jpg")
posts << post2

# 投稿 3: 新江ノ島水族館 (Place)
post3 = Post.create!(title: "水族館のイルカショーに感動！", body: "新江ノ島水族館。潮風を感じながらコーヒーブレイク。", user: yoko, postable_type: "Place", postable_id: places[2].id)
attach_seed_image(post3, "enoshima_aqua.jpg")
posts << post3

# 投稿 4: 大阪市立科学館 (Place)
post4 = Post.create!(title: "プラネタリウム体験！", body: "大阪市立科学館。星空がとても綺麗で子供も静かに見ていた。", user: users[2], postable_type: "Place", postable_id: places[3].id)
attach_seed_image(post4, "planetarium.jpg")
posts << post4

# 投稿 5: 札幌円山動物園 (Place)
post5 = Post.create!(title: "冬の動物園は空いてて快適！", body: "円山動物園。ホッキョクグマはやっぱり迫力満点。", user: users[3], postable_type: "Place", postable_id: places[4].id)
attach_seed_image(post5, "sapporo_zoo.jpg")
posts << post5

# 投稿 6: リニア・鉄道館 (Place)
post6 = Post.create!(title: "リニア・鉄道館で歴史を学ぶ", body: "鉄道模型の展示が面白かった！", user: users[4], postable_type: "Place", postable_id: places[5].id)
attach_seed_image(post6, "train_model.jpg")
posts << post6

# 投稿 7: 福岡アンパンマンこどもミュージアムinモール (Place)
post7 = Post.create!(title: "アンパンマンに夢中！", body: "福岡のミュージアム。ずっと体を動かして遊べるので助かる。帰りに食べたもつ鍋が美味しかった", user: users[5], postable_type: "Place", postable_id: places[6].id)
attach_seed_image(post7, "motunabe_fukuoka.jpg")
posts << post7

# 投稿 8: 仙台うみの杜水族館 (Place)
post8 = Post.create!(title: "仙台うみの杜水族館の迫力", body: "大水槽とイルカショーは本当に感動的。", user: users[6], postable_type: "Place", postable_id: places[7].id)
attach_seed_image(post8, "dolphin_aqua.jpg")
posts << post8

# 投稿 9: 上野動物園 (Place)
post9 = Post.create!(title: "パンダに会いに上野動物園へ", body: "レトロな雰囲気も良い。広いのでベビーカーがおすすめ。", user: users[7], postable_type: "Place", postable_id: places[8].id)
attach_seed_image(post9, "panda_zoo.jpg")
posts << post9

# 投稿 10: 富士急ハイランド (Place)
post10 = Post.create!(title: "富士急トーマスランドが楽しい！", body: "絶叫系は無理でも、小さい子向けのエリアで十分満足。観覧車は楽しんでた。", user: users[8], postable_type: "Place", postable_id: places[9].id)
attach_seed_image(post10, "fuji_amusement.jpg")
posts << post10

# --- ここから、以前「雑記」だった投稿にも関連付けを設定 ---

# 投稿 11: グルメフェスのお知らせ (Event)
posts << Post.create!(title: "グルメフェスのお知らせ", body: "来週のグルメフェス、絶対行くべき！", user: yoko, postable_type: "Event", postable_id: events[0].id)

# 投稿 12: 週末は星空観測 (Event)
posts << Post.create!(title: "週末は星空観測", body: "普段見られない星も見れるかも。", user: kenta, postable_type: "Event", postable_id: events[1].id)

# 投稿 13: （雑記）最近の悩み -> 新宿御苑 (Place) に関連付け
posts << Post.create!(title: "リフレッシュの必要性", body: "仕事とプライベートの両立が難しい...新宿御苑の自然に癒されたい。", user: users[9], postable_type: "Place", postable_id: places[1].id)

# 投稿 14: （雑記）おすすめの本 -> 大阪市立科学館 (Place) に関連付け（学びの場所）
posts << Post.create!(title: "知識欲を刺激する本", body: "最近読んだ『〇〇の法則』が面白かったです。科学館での学びと繋がる。", user: users[8], postable_type: "Place", postable_id: places[3].id)

# 投稿 15: 来月の予定 -> クラフトビール祭り (Event) に関連付け
posts << Post.create!(title: "来月の予定", body: "写真展とボランティア清掃に参加予定！クラフトビール祭りも楽しみ。子供が食べれるものは流石にないか", user: users[7], postable_type: "Event", postable_id: events[4].id)

# 投稿 16: カフェ巡りの記録 -> 新江ノ島水族館 (Place) 周辺に関連付け
posts << Post.create!(title: "カフェ巡りの記録", body: "今月は5軒の新規カフェを開拓しました。海辺のカフェが特に良かった。", user: users[6], postable_type: "Place", postable_id: places[2].id)

# 投稿 17: プログラミング学習 -> ITセミナー (Event) に関連付け
posts << Post.create!(title: "子供のプログラミング学習", body: "子供がプログラミングについて勉強中。ITセミナーで質問しようかな。", user: users[5], postable_type: "Event", postable_id: events[3].id)

# 投稿 18: 次の旅行先はどこに？ -> 札幌円山動物園 (Place) に関連付け
posts << Post.create!(title: "次の旅行先はどこに？", body: "冬の北海道（札幌円山動物園！）か、夏の沖縄で迷っています。", user: users[4], postable_type: "Place", postable_id: places[4].id)

# 投稿 19: 健康診断の結果 -> リニア・鉄道館 (Place) に関連付け（ランダム）
posts << Post.create!(title: "健康診断の結果", body: "特に問題なし！健康第一。休日は子供と鉄道館へ。", user: users[3], postable_type: "Place", postable_id: places[5].id)

# 投稿 20: 今日のランチ -> 上野動物園 (Place) 周辺に関連付け
posts << Post.create!(title: "今日のランチ", body: "オフィス近くの定食屋さん。コスパ最高！今度は上野周辺で探そう。", user: users[2], postable_type: "Place", postable_id: places[8].id)


# 投稿をシャッフルして、ランダムにタグ付け
posts.each do |post|
  PostTag.create!(post: post, tag: tags.sample)
  PostTag.create!(post: post, tag: tags.sample) unless rand(3) == 0 # 3分の1の確率で2つ目のタグ
end
puts "✅ 20 Posts created and tagged. (全ての投稿に場所またはイベントを設定)"
# ----------------------------------------
# 8. Relationships (Follows)
# ----------------------------------------
Relationship.destroy_all
Relationship.create!(follower_id: yoko.id, followed_id: kenta.id) # Alice -> kenta
Relationship.create!(follower_id: kenta.id, followed_id: yoko.id) # kenta -> Alice (相互フォロー)
Relationship.create!(follower_id: users[2].id, followed_id: yoko.id) # User3 -> Alice
Relationship.create!(follower_id: users[3].id, followed_id: kenta.id) # User4 -> kenta
Relationship.create!(follower_id: users[4].id, followed_id: users[5].id) # User5 -> User6
puts "✅ Relationships created."

# ----------------------------------------
# 9. Reviews (評価)
# ----------------------------------------
Review.destroy_all
Review.create!(user: kenta, post: posts[0], score: 5.0, body: "とても参考になりました！私も行ってみます。") # Post1へのReview
Review.create!(user: users[3], post: posts[0], score: 4.0, body: "写真が綺麗ですね。拝見して癒されました。")
Review.create!(user: yoko, post: posts[1], score: 4.5, body: "私もよく行く公園です。芝生が気持ちいいですよね。") # Post2へのReview
Review.create!(user: users[5], post: posts[10], score: 5.0, body: "グルメフェス楽しみ！情報ありがとう！") # Post11へのReview
puts "✅ Reviews created."

# ----------------------------------------
# 10. Likes, Bookmarks, Comments
# ----------------------------------------
Comment.destroy_all
ReviewLike.destroy_all
CommentLike.destroy_all
Bookmark.destroy_all

# Likes (Review Likes)
ReviewLike.create!(user: users[4], review: Review.first)
ReviewLike.create!(user: users[5], review: Review.last)

# Bookmarks (Post, Event, Placeのブックマーク)
Bookmark.create!(user: yoko, bookmarkable: events.sample)
Bookmark.create!(user: kenta, bookmarkable: posts.sample)
Bookmark.create!(user: users[2], bookmarkable: places.sample)

# Comments (Postへのコメント)
comment1 = Comment.create!(user: kenta, commetable: posts[0], body: "この時期の京都は最高ですよね！")
comment2 = Comment.create!(user: yoko, commetable: posts[0], body: "わかります！私もまた行きたいです。")
Comment.create!(user: users[4], commetable: posts[1], body: "この公園は犬を連れて行っても大丈夫ですか？")
Comment.create!(user: users[5], commetable: posts[1], body: "（コメントへの返信）リードをつけていればOKですよ！", parent_id: Comment.last.id) # リプライ例

# Comment Likes
CommentLike.create!(user: users[3], comment: comment1)
CommentLike.create!(user: users[2], comment: comment2)
puts "✅ Likes, Bookmarks, Comments created."

# ----------------------------------------
# 11. Notifications
# ----------------------------------------
Notification.destroy_all
# Alice宛の通知: kentaからのフォロー
Notification.create!(visitor_id: kenta.id, visited_id: yoko.id, action: "follow")
# Alice宛の通知: kentaからのPostへのコメント
Notification.create!(visitor_id: kenta.id, visited_id: yoko.id, action: "comment", post_id: posts[0].id, comment_id: comment1.id)
# kenta宛の通知: User4からのReviewへのいいね
Notification.create!(visitor_id: users[4].id, visited_id: kenta.id, action: "like", review_id: Review.first.id)
puts "✅ Notifications created."

puts "--- Seeding Data Finished ---"