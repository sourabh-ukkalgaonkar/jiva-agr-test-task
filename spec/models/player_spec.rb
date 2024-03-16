# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Player do
  let(:player_details) do
    {
      p1_ships_positions: '1,1:2,0:2,3:3,4:0,0',
      p2_ships_positions: '0,1:2,3:3,2:3,4:4,1',
      p1_move_positions: '0,1:4,3:2,3:3,1:4,1',
      p2_move_positions: '0,1:0,0:1,1:2,3:3,4'
    }
  end

  before(:each) do
    @player1 = Player.new(player_details[:p1_ships_positions], player_details[:p1_move_positions])
    @player2 = Player.new(player_details[:p2_ships_positions], player_details[:p2_move_positions])
  end

  context 'Ship Destroyed' do
    it "player1's destroyed ship by player2" do
      destroyed_ships = [[1, 1], [2, 3], [3, 4], [0, 0]]

      expect(@player1.ships_destroyed(@player2)).to eq(destroyed_ships)
      expect(@player1.ships_destroyed(@player2).count).to be(destroyed_ships.count)
    end

    it "player2's destroyed ship ship player1" do
      destroyed_ships = [[0, 1], [2, 3], [4, 1]]

      expect(@player2.ships_destroyed(@player1)).to eq(destroyed_ships)
      expect(@player2.ships_destroyed(@player1).count).to be(destroyed_ships.count)
    end
  end

  context 'Missile Missed' do
    it "player1's missed missile after making attack to player2" do
      missile_missed = [[4, 3], [3, 1]]

      expect(@player1.missile_missed(@player2)).to eq(missile_missed)
      expect(@player1.missile_missed(@player2).count).to be(missile_missed.count)
    end

    it "player2's missed missile after making attack to player1" do
      missile_missed = [[0, 1]]

      expect(@player2.missile_missed(@player1)).to eq(missile_missed)
      expect(@player2.missile_missed(@player1).count).to be(missile_missed.count)
    end
  end

  context 'Alived Ships' do
    it "player1's Alived Ship after attack of player2" do
      alived_ships_of = [[2, 0]]

      expect(@player1.alived_ships_of(@player2)).to eq(alived_ships_of)
      expect(@player1.alived_ships_of(@player2).count).to be(alived_ships_of.count)
    end

    it "player2's Alived Ship after attack of player1" do
      alived_ships_of = [[3, 2], [3, 4]]

      expect(@player2.alived_ships_of(@player1)).to eq(alived_ships_of)
      expect(@player2.alived_ships_of(@player1).count).to be(alived_ships_of.count)
    end
  end
end
