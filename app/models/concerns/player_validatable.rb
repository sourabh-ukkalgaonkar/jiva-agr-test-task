# frozen_string_literal: true

# Module to add Player Level Validation
module PlayerValidatable
  extend ActiveSupport::Concern

  included do
    validate :max_positions
    validate :input_count

    private

    def max_positions
      {
        p1_ship_positions: player1.ship_positions,
        p1_move_positions: player1.missile_positions,
        p2_ship_positions: player2.ship_positions,
        p2_move_positions: player2.missile_positions
      }.each do |key, values|
        errors.add(key, 'Value Must be inside the matrix size') unless max_value(values)
      end
    end

    def max_value(values)
      values.map { |value| value[0] }.compact.max < (grid_size) && values.map { |value| value[1] }.compact.max < (grid_size)
    end

    def input_count
      {
        p1_ship_positions: player1.ship_positions,
        p2_ship_positions: player2.ship_positions
      }.each do |key, values|
        errors.add(key, 'must equal to total_ships size') unless values.count == total_ships
      end

      {
        p1_move_positions: player1.missile_positions,
        p2_move_positions: player2.missile_positions
      }.each do |key, values|
        errors.add(key, 'must equal to total_missiles size') unless values.count == total_missiles
      end
    end
  end
end
