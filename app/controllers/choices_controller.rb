class ChoicesController < ApplicationController
  def index
    @choices = Choice.all
    @choice = Choice.new
    @win = win
  end

  def update
    Choice.update(choice_params)
    redirect_to root_path
  end

  def win
    lines = [[1, 2, 3],
             [4, 5, 6],
             [7, 8, 9]]
    columns = [[1, 4, 7],
               [2, 5, 8],
               [3, 6, 9]]
    diagonals = [[1, 5, 9],
                 [3, 5, 7]]

    lines_check(lines) || lines_check(columns) || lines_check(diagonals)

  end

  def lines_check(lines)
    victory = false
    lines.each do |line|
      line_through = []
      line.each do |position|
        positions_mark = Choice.all.find_by(position: position).mark
        line_through.append(positions_mark) unless line_through.include?(positions_mark)
      end
      victory = true if line_through.length == 1 && line_through[0] != 'none'
    end
    victory
  end

  private

  def choice_params
    params.require(:choice).permit(:position, :mark)
  end
end
