class CatsController < ApplicationController

  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find_by(id: params[:id])
    render :show
  end

  def new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    if @cat.save
      redirect_to cat_url(@cat)
    else
      render(
        json: @cat.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def edit
    @cat = Cat.find_by(id: params[:id])
    render :edit
  end

  def update
    @cat = Cat.update(params[:id], cat_params)
    if @cat.save
      redirect_to cat_url(@cat)
    else
      render(
        json: @cat.errors.full_messages, status: :unprocessable_entity
      )
    end
  end


  private

  def cat_params
    params.require(:cat).permit(:name, :sex, :birth_date, :description, :color)
  end
end
