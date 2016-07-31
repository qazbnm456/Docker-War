FROM phusion/passenger-ruby23
MAINTAINER Boik Su "lobsiinvok@tdohacker.org"

ENV HOME /root
ENV RAILS_ENV production
RUN usermod -aG docker_env app

CMD ["/sbin/my_init"]

# https://forums.docker.com/t/using-docker-in-a-dockerized-jenkins-container/322/6
RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y lxc \
  && apt-get install -y imagemagick libmagickwand-dev

WORKDIR /tmp
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN gem install bundler \
  && bundle install
RUN rm -f /etc/service/nginx/down
RUN rm /etc/nginx/sites-enabled/default

ADD http_nginx.conf /etc/nginx/sites-available/http_nginx.conf
ADD https_nginx.conf /etc/nginx/sites-available/https_nginx.conf
ADD rails-env.conf /etc/nginx/main.d/rails-env.conf
RUN mkdir -p /etc/my_init.d
ADD script/install_dependencies.sh /etc/my_init.d/install_dependencies.sh
ADD script/setup_lets_encrypt.sh /etc/my_init.d/setup_lets_encrypt.sh
ADD script/config.sh /home/app/config.sh

ADD . /home/app/project_name
WORKDIR /home/app/project_name
RUN chown -R app:app /home/app/project_name
RUN sudo -u app RAILS_ENV=production bundle exec rake assets:precompile --trace
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*