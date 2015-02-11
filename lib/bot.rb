# coding: utf-8
require 'file_control'

class Bot

  def initialize(path=nil)
    Birthday.filepath = path
    if Birthday.file_exists?
      puts "Foi encontrado o ficheiro de aniversarios"
    elsif Birthday.create_file
      puts "Foi criado um ficheiro para os aniversarios"
    else
      puts "Nada a ser feito exiting....\n\n"
      exit!
    end
  end

  def introduction
    puts "<< Welcome to Slack Birthday-Poster >>"
    puts "Just sit back while we do all the work for you"
  end

  def shut_down
    puts "\nShutting down!! Thank you for using this software!"
    sleep 1
  end

  def format_text(result)
    nomes_finais = ''
    if result.length == 1
      nomes_finais+= result[0][0] + ' ' + result[0][1]
      birthday_phrase = '"A jeKnowledge deseja-te um feliz aniverário ' + nomes_finais  + ' continua o bom trabalho!!!"'
    else
      nomes_finais = ''
      index = 0
      result.each do |nomes|
        if index <= result.length - 1
          nomes_finais += nomes[0] + ' ' + nomes[1]+', '
        else
          nomes_finais += nomes[0] + ' ' + nomes[1]
        end
        index+= 1
      end
      birthday_phrase = '"A jeKnowledge deseja um feliz aniverário a: ' + nomes_finais  + ' continuem o bom trabalho!!!"'
    end
    initword='curl -X POST --data-urlencode \'payload={"channel": "#birthday_test", "username": "jk_birthdayBot", "text": '
        resultado= initword + birthday_phrase + ', "icon_emoji": ":ghost:"}\'  https://hooks.slack.com/services/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'
        system(resultado)
        puts "\nMessage sent!"
        sleep(60)
  end

  def launch!
    introduction
    while true
      Signal.trap("INT") {
        shut_down
        exit
      }
      time1 = Time.new
      birthdays = Birthday.get_birthdays
      #p birthdays
      result=[]
      birthdays.each do |pessoa|
        p pessoa
        if pessoa[3].to_i == time1.month && pessoa[4].to_i == time1.day
          result << pessoa
        end
      end
      p result
      if result.length != 0
        format_text(result)
      end
      sleep(60)
    end
  end
end
