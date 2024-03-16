class GamesController < ApplicationController
  def new
  end

  def result
    @game = Game.new(game_params)
  end

  private

  def game_params
    params.require(:game).permit(
                                  :grid_size, 
                                  :total_ships, 
                                  :p1_ships_positions, 
                                  :p2_ships_positions, 
                                  :total_missiles, 
                                  :p1_move_positions, 
                                  :p2_move_positions)
  end
end
