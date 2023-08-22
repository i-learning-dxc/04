FROM ruby:3.1.4-alpine
ADD ./ /app/
WORKDIR /app
ENV PORT 5000
EXPOSE 5000

RUN bundle install
RUN ls
CMD ["sh", "-c", "while :; do ruby ./server.rb; done"]
