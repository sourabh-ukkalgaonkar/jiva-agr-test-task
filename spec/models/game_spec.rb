# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Game do
  let(:game_attributes) do
    {
      grid_size: 5,
      total_ships: 5,
      p1_ships_positions: '1,1:2,0:2,3:3,4:4,3',
      p2_ships_positions: '0,1:2,3:3,0:3,4:4,1',
      total_missiles: 5,
      p1_move_positions: '0,1:4,3:2,3:3,1:4,1',
      p2_move_positions: '0,1:0,0:1,1:2,3:4,3'
    }
  end

  it 'Should have valid game' do
    game = Game.new(game_attributes)
    expect(game.valid?).to be_truthy
  end

  context 'Invalid Grid Size' do
    it 'Grid Size Should be greater then zero' do
      game = Game.new(game_attributes.merge(grid_size: 0))
      expect(game.valid?).to be_falsey
      expect(game.errors.full_messages).to include('Grid size must be greater than 0')
    end

    it 'Grid Size Should be less than or equal to 10' do
      game = Game.new(game_attributes.merge(grid_size: 11))
      expect(game.valid?).to be_falsey
      expect(game.errors.full_messages).to include('Grid size must be less than or equal to 10')
    end
  end

  context 'Invalid Total Ships' do
    it 'Total Ships Should be greater then zero' do
      game = Game.new(game_attributes.merge(total_ships: nil))
      expect(game.valid?).to be_falsey
      expect(game.errors.full_messages).to include('Total ships must be a number between 1 and 12')
    end

    it 'Total Ships Should be less than or equal to 18' do
      game = Game.new(game_attributes.merge(grid_size: 6, total_ships: 20))
      expect(game.valid?).to be_falsey
      expect(game.errors.full_messages).to include('Total ships must be a number between 1 and 18')
    end
  end

  context 'Invalid Ship Positions' do
    it 'p1_ships_positions and p2_ships_positions should be equal to total_ships size' do
      game = Game.new(game_attributes.merge(p1_ships_positions: '1,1:2,0:2,3:3,4',
                                            p2_ships_positions: '0,1:2,3:3,0:3,4'))
      expect(game.valid?).to be_falsey
      expect(game.errors.full_messages).to include('P1 ship positions must equal to total_ships size')
      expect(game.errors.full_messages).to include('P2 ship positions must equal to total_ships size')
    end

    it 'p1_ships_positions and p2_ships_positions should be in valid format' do
      game = Game.new(game_attributes.merge(p1_ships_positions: '1,1:2,0:', p2_ships_positions: '0,1:2,3:3,0:3,'))
      expect(game.valid?).to be_falsey
      expect(game.errors.full_messages).to include('P1 ships positions is not in the correct format')
      expect(game.errors.full_messages).to include('P2 ships positions is not in the correct format')
    end
  end

  context 'Invalid Total Missiles' do
    it 'Total Missiles Should be greater then zero' do
      game = Game.new(game_attributes.merge(total_missiles: nil))
      expect(game.valid?).to be_falsey
      expect(game.errors.full_messages).to include('Total missiles must be a number between 1 and 12')
    end

    it 'Total Missiles Should be less than or equal to 12' do
      game = Game.new(game_attributes.merge(total_missiles: 20))
      expect(game.valid?).to be_falsey
      expect(game.errors.full_messages).to include('Total missiles must be a number between 1 and 12')
    end
  end

  context 'Invalid Ship Positions' do
    it 'p1_move_positions and p2_move_positions should be equal to total_missiles size' do
      game = Game.new(game_attributes.merge(p1_move_positions: '1,1:2,0:2,3:3,4',
                                            p2_move_positions: '0,1:2,3:3,0:3,4'))
      expect(game.valid?).to be_falsey
      expect(game.errors.full_messages).to include('P1 move positions must equal to total_missiles size')
      expect(game.errors.full_messages).to include('P2 move positions must equal to total_missiles size')
    end

    it 'p1_move_positions and p2_move_positions should be in valid format' do
      game = Game.new(game_attributes.merge(p1_move_positions: '0,1:4,3:2,3:3,1:4,',
                                            p2_move_positions: '0,1:0,0:1,1:2,3:'))
      expect(game.valid?).to be_falsey
      expect(game.errors.full_messages).to include('P1 move positions is not in the correct format')
      expect(game.errors.full_messages).to include('P2 move positions is not in the correct format')
    end
  end
end
