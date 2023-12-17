# メインのサンプルユーザーを1人作成する
User.create!(username:  "sakana",
             email: "sakana@example.com",
             password:              "foobar",
             password_confirmation: "foobar")

# 追加のユーザーをまとめて生成する
9.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(username:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

# 20記事
users = User.order(:created_at).take(6)
20.times do |i|
  users.each.with_index(1) do |user, j|
    user.articles.create!(title: "article#{j}-#{i+1}", content: Faker::Lorem.sentence(word_count: 30), slug: "slug#{j}-#{i+1}")
  end
end