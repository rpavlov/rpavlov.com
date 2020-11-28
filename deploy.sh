bundle exec middleman build
rsync -rvI $PWD/build/* pi:/var/www/html
