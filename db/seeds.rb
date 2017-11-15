# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Author.create([
  { name: '夏目漱石', name_en: 'Soseki Natsume', name_tw: '夏目漱石' }
])

soseki = Author.find_by(name: '夏目漱石')
Book.create([
  { title: '吾輩は猫である', title_en: 'I am a Cat', title_tw: '我是一隻貓', author: soseki },
  { title: '坊ちゃん', title_en: 'Boy', title_tw: '兒子', author: soseki },
  { title: 'こころ', title_en: 'Mind', title_tw: nil, author: soseki }
])
