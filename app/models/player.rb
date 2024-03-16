# frozen_string_literal: true

# class to handle player's info
class Player
  attr_accessor :ship_positions, :missile_positions

  def initialize(ship_position_str, missile_position_str)
    @ship_positions = ship_position_str.split(':').map { |pos| pos.split(',').map(&:to_i) }
    @missile_positions = missile_position_str.split(':').map { |pos| pos.split(',').map(&:to_i) }
  end

  # method to get ship destroyed ship of player1 by player2's missile.
  def ships_destroyed(player)
    ship_positions & player.missile_positions
  end

  # method to get missile missed by player1 with respect to player2's ships position.
  def missile_missed(player)
    missile_positions - player.ship_positions
  end

  # method to get alived of player1 after attack by player2's missile
  def alived_ships_of(player)
    ship_positions - player.missile_positions
  end
end
