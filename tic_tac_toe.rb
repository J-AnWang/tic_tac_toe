# 會贏得所有組合
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def play(board, counter)
  if current_player(counter) == "X"
    puts "請輸入你要下棋的位子， 1～9 擇一"
    position = gets.chomp.to_i - 1
  else
    puts "輪到電腦下棋"
    position = computer_play(board)
  end
  if valid_move?(board,position)
    board[position] = current_player(counter)
    display_board(board)
    return won?(board, counter)
  else
    play(board, counter)
  end
end

def computer_play(board)
  best_choice(board)
end

def display_board(board)
  puts " "
  puts " #{board[0]} | #{board[1]} | #{board[2]}  "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]}  "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]}  "
  puts " "
end

def turn(board)
  counter = 1
  while counter <= 9
    puts "Round #{counter}, #{current_player(counter)} turn"
    if play(board, counter)
      puts "#{current_player(counter)} won!!!"
      puts "Gameover"
      break
    end
    counter += 1
  end
end
#  判斷現在是由誰在下
def current_player(counter)
  if counter % 2 == 0
    return "O"
  else
    return "X"
  end
end
# 判斷是否有人贏了
def won?(board, counter)
  WIN_COMBINATIONS.each do |win_combo|
    if (board[win_combo[0]] == "X" && board[win_combo[1]] == "X" && board[win_combo[2]] == "X") || (board[win_combo[0]] == "O" && board[win_combo[1]] == "O" && board[win_combo[2]] == "O")
      return true
    end
  end
  return false
end
# 判斷起步是否重複或是非輸入數字
def valid_move?(board, position)
  position >= 0 && position < 9 && board[position] == " "
end
# 電腦選出最佳棋步
def best_choice(board)
  # 回傳值均為陣列，0的位置放電腦要下的位置，1的位置放boolean
  # 電腦先判斷是否有贏的機會，再來判斷對手有沒有贏的機會
  # 如果上述都沒有，電腦會判斷最快因的位置
  # 在沒有就是隨機下
  checkmate = checkmate(board)
  defence = defence(board)
  possible = possible(board)
  if checkmate[1]
    return checkmate[0]
  elsif defence[1]
    return defence[0]
  elsif possible[1]
    return possible[0]
  else
    random(board)
  end
end
# 電腦有可能贏的位置
def checkmate(board)
  WIN_COMBINATIONS.each do |win_combo|
    if (board[win_combo[0]] == "O" && board[win_combo[1]] == "O" && board[win_combo[2]] == " ")
      return [win_combo[2], true]
    elsif (board[win_combo[0]] == " " && board[win_combo[1]] == "O" && board[win_combo[2]] == "O")
        return [win_combo[0], true]
    elsif (board[win_combo[0]] == "O" && board[win_combo[1]] == " " && board[win_combo[2]] == "O")
        return [win_combo[1], true]
    end
  end
  return [" ",false]
end
# 對手有可能贏的位置
def defence(board)
  WIN_COMBINATIONS.each do |win_combo|
    if (board[win_combo[0]] == "X" && board[win_combo[1]] == "X" && board[win_combo[2]] == " ")
      return [win_combo[2], true]
    elsif (board[win_combo[0]] == " " && board[win_combo[1]] == "X" && board[win_combo[2]] == "X")
        return [win_combo[0], true]
    elsif (board[win_combo[0]] == "X" && board[win_combo[1]] == " " && board[win_combo[2]] == "X")
        return [win_combo[1], true]
    end
  end
  return [" ",false]
end
# 最快贏的位置
def possible(board)
  WIN_COMBINATIONS.each do |win_combo|
    if (board[win_combo[0]] == "O" && board[win_combo[1]] == " " && board[win_combo[2]] == " ")
      return [[win_combo[1], win_combo[2]].sample, true]
    elsif (board[win_combo[0]] == " " && board[win_combo[1]] == " " && board[win_combo[2]] == "O")
      return [[win_combo[0], win_combo[1]].sample, true]
    elsif (board[win_combo[0]] == " " && board[win_combo[1]] == "O" && board[win_combo[2]] == " ")
      return [[win_combo[0], win_combo[2]].sample, true]
    end
  end
  return [" ",false]
end
# 隨機下
def random(board)
  blank = []
  board.each_with_index do |input, index|
    if input == " "
      blank.push(index)
    end
  end
  return blank.sample
end

#####################################################
#執行程序
board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
puts "**********規則**********"
puts "你開了一局新的井字遊戲"
puts "請以 1-9 數字對應棋盤位子"
puts "************************"
display_board([1, 2, 3, 4, 5, 6, 7, 8, 9])
turn(board)
