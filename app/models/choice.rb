class Choice < ApplicationRecord
  # Create a model that will hold the position of the mark and which mark it is (circle, cross)
  validates :mark, inclusion: { in: %w[circle cross none] }
  validates :position, uniqueness: true, inclusion: 1..9

end
