class Birthday
  @@filepath = nil

  def self.filepath=(path=nil)
    @@filepath = File.join(APP_ROOT, path)
  end

  def self.file_exists?
    if @@filepath && File.exists?(@@filepath)
      return true
    else
      return false
    end
  end

  def self.file_usable?
    return false unless @@filepath
    return false unless File.exists?(@@filepath)
    return false unless File.readable?(@@filepath)
    return true
  end

  def self.create_file
    File.open(@@filepath, 'w') unless file_exists?
    return file_usable?
  end

  def import_line(line)
    line_array = line.split(' ')
    @primeiro_nome, @ultimo_nome, @ano, @mes, @dia = line_array
    return line_array
  end

  def self.get_birthdays
    birthdays = []
    if file_usable?
      file = File.new(@@filepath, 'r')
      file.each_line do |line|
        birthdays << Birthday.new.import_line(line.chomp)
      end
      file.close
    end
    return birthdays
  end
end
