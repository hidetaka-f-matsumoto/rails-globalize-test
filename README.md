# Testing globalize-gem, migration of existing data
## Setup application with Docker

```sh
docker build -t hide/rails-globalize-test .
docker create -t --name rails-globalize-test \
                -v `pwd`:/var/myapp \
                -p 3999:3000 \
                hide/rails-globalize-test
docker start rails-globalize-test
docker exec -it rails-globalize-test sh
```

```
bundle
rake db:migrate
```

## Migration of existing data

```sh
rake translations:migrate CLASS=Author
rake translations:migrate CLASS=Book
```

## Check translations

```ruby
/var/myapp # rails c
Loading development environment (Rails 5.1.4)
[1] pry(main)> book = Book.first
  Book Load (1.2ms)  SELECT  "books".* FROM "books" ORDER BY "books"."id" ASC LIMIT ?  [["LIMIT", 1]]
=> #<Book:0x0055ae6610e838
 id: 1,
 title_en: "I am a Cat",
 title_tw: "我是一隻貓",
 author_id: 1,
 created_at: Wed, 15 Nov 2017 02:30:51 UTC +00:00,
 updated_at: Wed, 15 Nov 2017 02:30:51 UTC +00:00>
[2] pry(main)> book.title
  Book::Translation Load (2.9ms)  SELECT "book_translations".* FROM "book_translations" WHERE "book_translations"."book_id" = ?  [["book_id", 1]]
=> "I am a Cat"
[3] pry(main)> book.author.name
  Author Load (1.8ms)  SELECT  "authors".* FROM "authors" WHERE "authors"."id" = ? LIMIT ?  [["id", 1], ["LIMIT", 1]]
  Author::Translation Load (1.4ms)  SELECT "author_translations".* FROM "author_translations" WHERE "author_translations"."author_id" = ?  [["author_id", 1]]
=> "Soseki Natsume"
[4] pry(main)> I18n.locale = :ja
=> :ja
[5] pry(main)> book.title
=> "吾輩は猫である"
[6] pry(main)> book.author.name
=> "夏目漱石"
[7] pry(main)> I18n.locale = :'zh-TW'
=> :"zh-TW"
[8] pry(main)> book.title
=> "我是一隻貓"
[9] pry(main)> book.author.name
=> "夏目漱石"
```
