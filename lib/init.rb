require 'date'
require_relative 'slack-post'


Slack::Post.configure(
  subdomain: 'myslack',
  token: 'xoxp-3666247738-3666247752-3664405749-809162',
  username: 'tiagonbotelho'
)
Slack::Post.post 'Ola o meu nome e tiago', '#'
