require 'unicode_utils/downcase'

class Game
  attr_reader :letters, :errors, :good_letters, :bad_letters, :status

  attr_accessor :version

  MAX_ERRORS = 7

  def initialize(slovo)
    @letters = get_letters(slovo)
    @errors = 0
    @good_letters = []
    @bad_letters = []
    @status = :in_progress # :won, :lost
  end

  def get_letters(slovo)
    if slovo == nil || slovo == ""
      abort "Вы не ввели слово для игры"
    end

  slovo.encode('UTF-8').split("")
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

  def max_errors
    MAX_ERRORS
  end

  def errors_left
    MAX_ERRORS - @errors
  end

  def is_good?(letter)
    letters.include?(letter) ||
      (letter == "е" && letters.include?("ё")) ||
      (letter == "ё" && letters.include?("е")) ||
      (letter == "и" && letters.include?("й")) ||
      (letter == "й" && letters.include?("и"))
  end

  def add_letter_to(letters, letter)
    letters << letter
    letters << "ё" if letter == "е"
    letters << "е" if letter == "ё"
    letters << "й" if letter == "и"
    letters << "и" if letter == "й"
  end

  def solved?
    (letters.uniq.sort - good_letters.uniq.sort).empty?
  end

  def repeated?(letter)
    good_letters.include?(letter) || bad_letters.include?(letter)
  end

  def lost?
    @status == :lost || @errors >= MAX_ERRORS
  end

  def in_progress?
    @status == :in_progress
  end

  def won?
    @status == :won
  end

  def next_step(letter)
    return if @status == :lost || @status == :won
    return if repeated?(letter)

    if is_good?(letter)
      add_letter_to(good_letters, letter)

      @status = :won if solved?
    else
      add_letter_to(bad_letters, letter)

      @errors += 1

      @status = :lost if lost?
    end
  end
end
