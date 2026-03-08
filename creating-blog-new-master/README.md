# README
wikiの仕様書を参考に機能を実装してください。

### 環境構築方法   
```
docker-compose build  
docker-compose run --rm web bash  
bundle install  
bundle exec rake db:create
bundle exec rake db:migrate  
bundle exec rake db:seed  
bundle exec rake db:migrate RAILS_ENV=test
```

もしくは

```
docker-compose build  
docker-compose run --rm web bundle install
docker-compose run --rm web bundle exec rake db:create  
docker-compose run --rm web bundle exec rake db:migrate
docker-compose run --rm web bundle exec rake db:seed  
docker-compose run --rm web bundle exec rake db:migrate RAILS_ENV=test  
```   

### アプリ起動
```
docker-compose up
```  

### コマンド各種  
```
docker-compose run --rm web bundle exec rspec  
docker-compose run --rm web bundle exec rspec 'rspecファイルの相対パス'
docker-compose run --rm web bundle exec rubocop  
```

### mysql確認  
```
docker-compose up -d mysql  
docker-compose exec mysql bash
mysql -u root -p creating_blog_development
passwordはdocker-compose.ymlの9行目参照
```