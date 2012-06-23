class Tic
  def initialize
    # Constansts
    @NONE = "_"
    @USER_MOVE = "x"
    @COMP_MOVE = "0"

    @field = Array.new(9, @NONE)
    @win_positions = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [7, 5, 3], [1, 5, 9]]
  end

  def play
    show
    view
    user_move
    game_over?
    move
    game_over?(@COMP_MOVE)
    play    
  end
private
  def show
    puts "\nPlease make move", "7 8 9", "4 5 6", "1 2 3", ""
  end

  def view
    @field.each_with_index do |item, index|
      index += 1
      print item
      if index % 3 != 0
        print " "
      elsif
        puts
      end
    end
    puts
  end

  def user_move
    while
      pos = gets.to_i
      next if pos > 9 || pos < 1
      if pos > 6
        pos -= 6
      elsif pos < 4
       pos += 6
      end
      if @field[pos-1] != @NONE
        puts "This place are settled!"
      else
        @field[pos-1] = @USER_MOVE
        break
      end
   end
  end

  def move
    if @field[4] == @NONE
      @field[4] = @COMP_MOVE
      return
    end
    if @field.count(@NONE) == 8
      perh = [1, 3, 7, 9].shuffle.first
      @field[perh-1] = @COMP_MOVE
      return
    end
    may_be = check
    if check == 0
      [1, 3, 7, 9].each do |index|
        if @field[index] == @NONE
          @field[index] = @COMP_MOVE
          return
        end
      end
      for_me = Array.new
      @field.each_with_index do |item, index|
        if item == @NONE
          for_me << index
        end
      end
      @field[for_me.shuffle.first] = @COMP_MOVE
    else
      @field[may_be-1] = @COMP_MOVE
    end
  end

  def check
    @win_positions.each do |combination|
      comp = 0
      user = 0
      wow = 0
      combination.each_with_index do |numb, index|
        if @field[numb-1] == @COMP_MOVE
          comp += 1
        elsif @field[numb-1] == @USER_MOVE
          user += 1
        else
          wow = index
        end
      end
      next if comp+user == 3
      if (comp == 2 && user == 0) || (user == 2 && comp == 0)
        return combination[wow]
      end
    end
    return 0    
  end

  def game_over?(what = @USER_MOVE)
    @win_positions.each do |combination|
      count = 0
      combination.each do |numb|
        if @field[numb-1] == what
          count += 1
        else
          break
        end
      end
      if count == 3
        who = (what == @USER_MOVE) ? "You" : "Comp"
        puts "\n#{who} won!"
        view
        exit!
      end
    end
    if what == @USER_MOVE && !(@field.include?(@NONE))
      puts "\nIt's a draw"
      view
      exit!
    end
  end
end

game = Tic.new
game.play