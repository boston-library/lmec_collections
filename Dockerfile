FROM ruby:3.4.4

RUN apt-get update -qq && apt-get install -y curl build-essential libpq-dev

RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
    apt-get install -y nodejs

RUN npm install --global yarn

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY package.json yarn.lock ./
RUN yarn install

COPY . .

COPY entrypoint.sh /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

CMD ["bin/dev"]
