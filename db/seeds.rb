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

puts "seedの実行が完了しました"