# frozen_string_literal: true

# Module to add Game Level Validation
module GameValidatable
  extend ActiveSupport::Concern

  included do
    validates :grid_size, :total_ships, :p1_ships_positions, :p2_ships_positions, :total_missiles, :p1_move_positions,
              :p2_move_positions, presence: true
    validates_format_of :p1_ships_positions, :p2_ships_positions, :p1_move_positions, :p2_move_positions,
                        with: /\A\d,\d(:\d,\d)*\z/, message: 'is not in the correct format'
    validates :grid_size, numericality: { greater_than: 0, less_than_or_equal_to: 10 }
    validate :total_ships, :valid_total_ships
    validate :total_missiles, :valid_total_missiles

    private

    def valid_total_ships
      return if total_ships.is_a?(Numeric) && total_ships.positive? && total_ships <= max_total_ships

      errors.add(:total_ships, "must be a number between 1 and #{max_total_ships}")
    end

    def valid_total_missiles
      return if total_missiles.is_a?(Numeric) && total_missiles.positive? && total_missiles <= max_total_ships

      errors.add(:total_missiles, "must be a number between 1 and #{max_total_ships}")
    end

    def max_total_ships
      (grid_size**2 / 2)
    end
  end
end
