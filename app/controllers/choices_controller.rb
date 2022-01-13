class ChoicesController < ApplicationController
  def index
    @choices = Choice.all
  end

  def create
    Choice.create(choice_params)
    render new
  end
end
