class ChoicesController < ApplicationController
  before_action :authenticate_user!

  def index
    @choices = Choice.all
    @choice = Choice.new
    @win = win
  end

  def update
    user_id = params['choice']['current_user'].to_i
    progress = Choice.where(mark: 'none').length
    if (user_id.odd? && progress.odd?) || (user_id.to_i.even? && progress.even?)
      Choice.update(choice_params)
      redirect_to root_path
    else
      redirect_to root_path, notice: 'This is not your turn.'
    end
  end

  def destroy
    Choice.destroy_all
    (1..9).each do |number|
      Choice.create(position: number, mark: 'none')
    end
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
