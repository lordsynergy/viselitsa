# encoding: utf-8
# Класс WordReader, отвечающий за чтение слова для игры.
class WordReader
  # Сохраним старую возможность читать слово из аргументов командной строки. В
  # качестве отедльного метода read_from_args для обратной совместимости.
  def read_from_args
    return ARGV[0]
  end

  # Метод read_from_file, возвращающий случайное слово, прочитанное из файла,
  # имя которого нужно передать методу в качестве единственного аргумента.
  def read_from_file(file_name)
    begin
      file = File.new(file_name, "r:UTF-8")
      lines = file.readlines
      file.close
    rescue SystemCallError
      # Если файл со словами не удалось открыть, нет смысла играть, поэтому тут
      # в пору закрыть программу и написать об этом пользователю
      abort "Файл со словами не найден!"
    end

    return lines.sample.chomp
  end
end
