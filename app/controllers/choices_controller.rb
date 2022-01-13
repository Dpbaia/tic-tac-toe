class ChoicesController < ApplicationController
  before_action :authenticate_user!

  def index
    @choices = Choice.all
    @choice = Choice.new
    @win = win
    @draw = Choice.where(mark: 'none').length.zero?
  end

  def update
    user_id = params['choice']['current_user'].to_i
    progress = Choice.where(mark: 'none').length
    # Only allow users to play when it's their turn
    if (user_id.odd? && progress.odd?) || (user_id.to_i.even? && progress.even?)
      Choice.update(choice_params)
      redirect_to root_path
    else
      redirect_to root_path, notice: 'This is not your turn.'
    end
  end

  def destroy
    # Reset the game so that it can be played again.
    Choice.destroy_all
    (1..9).each do |number|
      Choice.create(position: number, mark: 'none')
    end
    redirect_to root_path
  end


  private

  def win
    # Check winning conditions:
    lines = [[1, 2, 3],
             [4, 5, 6],
             [7, 8, 9]]
    columns = [[1, 4, 7],
               [2, 5, 8],
               [3, 6, 9]]
    diagonals = [[1, 5, 9],
                 [3, 5, 7]]
    checks = [lines_check(lines), lines_check(columns), lines_check(diagonals)]
    # Check if any of the tests have returned true, If it did, return the condition and who won.
    checks.find { |check| check[0] == true }
  end

  def lines_check(lines)
    # By default no one won and there is no victor
    victory_status = [false, nil]
    # Look at each line where it would be possible to reach a victory
    lines.each do |line|
      line_through = []
      # Then look at each individual position inside that line
      line.each do |position|
        # Find whether it is a cross or a circle
        positions_mark = Choice.all.find_by(position: position).mark
        # Append if it has not been added yet to the array
        line_through.append(positions_mark) unless line_through.include?(positions_mark)
      end
      # It is a victory if only one "mark" is in a single "victory-line", and it is not an empty mark.
      victory_status = [true, line_through[0]] if line_through.length == 1 && line_through[0] != 'none'
    end
    # Return if someone won and who
    victory_status
  end

  def choice_params
    params.require(:choice).permit(:position, :mark)
  end
end
