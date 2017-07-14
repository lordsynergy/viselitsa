require 'unicode_utils/downcase'

class Game

  def initialize(slovo)
    @letters = get_letters(slovo)
    @errors = 0
    @good_letters = []
    @bad_letters = []
    @status = 0
  end

  def get_letters(slovo)
    if slovo == nil || slovo == ""
      abort "Вы не ввели слово для игры"
    end

  return slovo.encode('UTF-8').split("")
  end

  # 1. спросить букву с консоли
  # 2. проверить результат
  def ask_next_letter
    puts "\n Введите следующую букву"

    letter = ""

    while letter == ""
      letter = STDIN.gets.encode('UTF-8').chomp
      letter = UnicodeUtils.downcase(letter)
    end
    next_step(letter)
  end

  def next_step(bukva)
    if @status == -1 || @status == 1
      return
    end

    if good_letters.include?(bukva) || bad_letters.include?(bukva)
      return
    end

    if letters.include?(bukva) ||
      (bukva == "е" && letters.include?("ё")) ||
      (bukva == "ё" && letters.include?("е")) ||
      (bukva == "и" && letters.include?("й")) ||
      (bukva == "й" && letters.include?("и"))
      good_letters << bukva

      good_letters << "ё" if bukva == "е"
      good_letters << "е" if bukva == "ё"
      good_letters << "й" if bukva == "и"
      good_letters << "и" if bukva == "й"

      if (letters.uniq.sort - good_letters.uniq.sort).empty?
        @status = 1
      end
    else
      @bad_letters << bukva
      @errors += 1

        if @errors >= 7
          @status = -1
        end
    end
  end

  # Далее методы, возвращающие поля класса для возможного использования этих полей в других классах
  def letters
    return @letters
  end

  def good_letters
    return @good_letters
  end

  def bad_letters
    return @bad_letters
  end

  def status
    return @status
  end

  def errors
    return @errors
  end

end
