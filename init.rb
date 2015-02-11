APP_ROOT = File.dirname(__FILE__)

$:.unshift(File.join(APP_ROOT, 'lib'))
require 'bot'

bot = Bot.new('aniversarios.txt')
bot.launch!
