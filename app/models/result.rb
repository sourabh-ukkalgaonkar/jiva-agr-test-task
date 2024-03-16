# frozen_string_literal: true

# class to calculate the result of the game
class Result
  attr_accessor :grid_size

  def initialize(grid_size)
    @grid_size = grid_size
  end

  def detailed_matrix(player1, player2)
    matrix = []
    (0..(grid_size - 1)).each do |i|
      matrix << (0..(grid_size - 1)).map do |j|
        if player1.ships_destroyed(player2).include?([i, j])
          'X'
        elsif player1.ship_positions.include?([i, j])
          'B'
        elsif player2.missile_positions.include?([i, j])
          'O'
        end
      end
    end
    matrix
  end

  def conclusion(player1, player2)
    ships_destroyed_by_player1 = player1.ships_destroyed(player2)
    ships_destroyed_by_player2 = player2.ships_destroyed(player1)

    if ships_destroyed_by_player1.count > ships_destroyed_by_player2.count
      'Player 1 Wins'
    elsif ships_destroyed_by_player2.count > ships_destroyed_by_player1.count
      'Player 2 Wins'
    else
      "It's Draw "
    end
  end
end
