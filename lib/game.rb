require 'pry'

class Game
    attr_accessor :board, :player_1, :player_2
    
    WIN_COMBINATIONS =[[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]

    def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
        @player_1 = player_1
        @player_2 = player_2
        @board = board
    end

    def current_player
        @board.turn_count % 2 == 0? player_1 : player_2
    end

    def draw?
        @board.full? && !won?
    end

    def won?
        WIN_COMBINATIONS.detect do |combo|
            @board.cells[combo[0]] == @board.cells[combo[1]] && @board.cells[combo[1]] == @board.cells[combo[2]] && (@board.cells[combo[0]] == "X" || @board.cells[combo[0]] == "O")
            #binding.pry 
        end
    end

    def over?
        draw? || won? 
    end

    def winner
        if won?
            @board.cells[won?.first]
        end
    end

    def turn
        puts "Please enter 1-9:"
        @board.display
        input = current_player.move(@board)
        if !@board.valid_move?(input)
            puts "Invalid move."
            turn
        else
            @board.update(input, current_player)
        end
    end

    def play
        while !over?
            turn
        end
        
        if won?
            puts "Congratulations #{winner}!"
        elsif draw?
            puts "Cat's Game!"
        end
    end
end