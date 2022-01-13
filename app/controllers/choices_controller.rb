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
    lines = [[1,2,3],
            [4,5,6],
            [7,8,9]]
    victory = false
    lines.each do |line|
      line_through = []
      line.each do |position|

      end

    end
    # column = [[1,4,7],
    #           [2,5,8],
    #           [3,6,9]]
    # diagonal = [[1,5,9]]
    if 1 == 2
      true
    else
      false
    end
  end

  private

  def choice_params
    params.require(:choice).permit(:position, :mark)
  end
end
