# frozen_string_literal: true

# class to handle the game inputs
class Game
  include ActiveModel::Validations
  include GameValidatable
  include PlayerValidatable

  attr_accessor :grid_size, :total_ships, :p1_ships_positions, :p2_ships_positions, :total_missiles,
                :p1_move_positions, :p2_move_positions

  def initialize(opts = {})
    @grid_size            = opts[:grid_size].to_i
    @total_ships          = opts[:total_ships].to_i
    @p1_ships_positions   = opts[:p1_ships_positions]
    @p2_ships_positions   = opts[:p2_ships_positions]
    @total_missiles       = opts[:total_missiles].to_i
    @p1_move_positions    = opts[:p1_move_positions]
    @p2_move_positions    = opts[:p2_move_positions]
  end

  def player1
    @player1 ||= Player.new(p1_ships_positions, p1_move_positions)
  end

  def player2
    @player2 ||= Player.new(p2_ships_positions, p2_move_positions)
  end
end
