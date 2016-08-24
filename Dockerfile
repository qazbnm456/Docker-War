FROM phusion/passenger-customizable
MAINTAINER Boik Su "boik@tdohacker.org"

ENV HOME /root
ENV RAILS_ENV production
RUN usermod -aG docker_env app

CMD ["/sbin/my_init"]

#   Build system and git.
RUN /pd_build/utilities.sh
#   Ruby support.
RUN /pd_build/ruby-2.3.1.sh
#   Opt-in for Redis.
RUN /pd_build/redis.sh

# https://forums.docker.com/t/using-docker-in-a-dockerized-jenkins-container/322/6
RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y lxc \
  && apt-get install -y imagemagick libmagickwand-dev sudo

WORKDIR /tmp
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN chown -R app.app /tmp \
  && gem install bundler \
  && bundle install --jobs 40 --retry 10
# Enable the Redis service.
RUN rm -f /etc/service/redis/down
# Enable the Nginx service.
RUN rm -f /etc/service/nginx/down
RUN rm /etc/nginx/sites-enabled/default
# Enable the Sidekiq service.
RUN mkdir /etc/service/sidekiq
ADD script/sidekiq.sh /etc/service/sidekiq/run

ADD http_nginx.conf /etc/nginx/sites-available/http_nginx.conf
ADD https_nginx.conf /etc/nginx/sites-available/https_nginx.conf
ADD rails-env.conf /etc/nginx/main.d/rails-env.conf
RUN mkdir -p /etc/my_init.d
ADD script/install_dependencies.sh /etc/my_init.d/install_dependencies.sh
ADD script/setup_lets_encrypt.sh /etc/my_init.d/setup_lets_encrypt.sh
ADD script/config.sh /home/app/config.sh

ADD . /home/app/project_name
RUN mkdir -p /home/app/project_name/tmp/pids
WORKDIR /home/app/project_name
RUN chown -R app:app /home/app/project_name
RUN sudo -u app RAILS_ENV=production bundle exec rake assets:precompile --trace
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
