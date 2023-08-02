#!/usr/bin/env bash
# exit on error
#set -o errexit

#bundle install
#yarn install
#yarn build 

#bundle exec rake assets:precompile

bin/render-build.sh内
#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exec rake assets:precompile
bundle exec rake assets:clean
bundle exec rake db:migrate

