class CatsController < ApplicationController
  def index
    @cats = Cat.all
    render :index
  end

  def create
    @cat = Cat.new(cat_params)

    if @cat.save!
      redirect_to cat_url(@cat)
    else
      redirect_to new_cat_url
    end
  end

  def update
    @cat = Cat.find_by(id: params[:id])

    if @cat.update(cat_params)
      redirect_to cat_url(@cat)
    else
      redirect_to edit_cat_url(@cat)
    end
  end

  def show
    @cat = Cat.find_by(id: params[:id])
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def edit
    @cat = Cat.find_by(id: params[:id])
    render :edit
  end

  private

  def cat_params
    params.require(:cat).permit(:birth_date, :color, :name, :sex, :description)
  end
end
