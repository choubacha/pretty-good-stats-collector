redis: redis-server
web:     REDIS_URL='redis://localhost:6379/2' bundle exec rackup
worker:  REDIS_URL='redis://localhost:6379/2' bundle exec sidekiq -r ./lib/pgsc.rb -C config/sidekiq.yml
sidekiq: REDIS_URL='redis://localhost:6379/2' bundle exec sidekiq -r ./lib/pgsc.rb -C config/sidekiq.yml
