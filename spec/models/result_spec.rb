# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Result do
  let(:result) { Result.new(5) }
  let(:player_details) do
    {
      p1_ships_positions: '1,1:2,0:2,3:3,4:0,0',
      p2_ships_positions: '0,1:2,3:3,2:3,4:4,1',
      p1_move_positions: '0,1:4,3:2,3:3,1:4,1:1,1',
      p2_move_positions: '0,1:0,0:1,1:2,3:3,4:4,4'
    }
  end

  let(:player_draw_details) do
    {
      p1_ships_positions: '1,1:2,0:2,3:3,4:4,3',
      p2_ships_positions: '0,1:2,3:3,0:3,4:4,1',
      p1_move_positions: '0,1:4,3:2,3:3,1:4,1',
      p2_move_positions: '0,1:0,0:1,1:2,3:4,3'
    }
  end

  context 'Detailed Matrix' do
    before(:each) do
      @player1 = Player.new(player_details[:p1_ships_positions], player_details[:p1_move_positions])
      @player2 = Player.new(player_details[:p2_ships_positions], player_details[:p2_move_positions])
    end
    it 'should generated the detailed matrix of player1' do
      detailed_matrix = result.detailed_matrix(@player1, @player2)
      expect(detailed_matrix).to eq([['X', 'O', nil, nil, nil], [nil, 'X', nil, nil, nil], ['B', nil, nil, 'X', nil],
                                     [nil, nil, nil, nil, 'X'], [nil, nil, nil, nil, 'O']])
    end

    it 'should generated the detailed matrix of player2' do
      detailed_matrix = result.detailed_matrix(@player2, @player1)
      expect(detailed_matrix).to eq([[nil, 'X', nil, nil, nil], [nil, 'O', nil, nil, nil], [nil, nil, nil, 'X', nil],
                                     [nil, 'O', 'B', nil, 'B'], [nil, 'X', nil, 'O', nil]])
    end
  end

  context 'Conclusion' do
    it 'Player2 should win the game' do
      player1 = Player.new(player_details[:p1_ships_positions], player_details[:p1_move_positions])
      player2 = Player.new(player_details[:p2_ships_positions], player_details[:p2_move_positions])

      expect(result.conclusion(player1, player2)).to eq('Player 2 Wins')
    end

    it 'Player1 should win the game' do
      player1 = Player.new(player_details[:p2_ships_positions], player_details[:p2_move_positions])
      player2 = Player.new(player_details[:p1_ships_positions], player_details[:p1_move_positions])

      expect(result.conclusion(player1, player2)).to eq('Player 1 Wins')
    end

    it 'Player1 and Player2 should finish with a draw' do
      player1 = Player.new(player_draw_details[:p1_ships_positions], player_draw_details[:p1_move_positions])
      player2 = Player.new(player_draw_details[:p2_ships_positions], player_draw_details[:p2_move_positions])

      expect(result.conclusion(player2, player1)).to eq("It's Draw")
    end
  end
end
