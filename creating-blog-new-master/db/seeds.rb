# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Article.create(title: 'タイトル', text: "本文\nテキスト") if Article.first.nil?

User.create(name: 'user', password: 'password') if User.first.nil?

# pageネーションの確認用に複数記事を作成
30.times do |n|
  Article.create!(
    title: "テスト記事#{n + 1}",
    text: "これはテスト記事#{n + 1}の本文です。"
  )
end
