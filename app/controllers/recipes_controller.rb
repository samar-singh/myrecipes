class RecipesController < ApplicationController

 def index
   #@recipes = Recipe.all.sort_by{|likes| likes.thumbs_up_total}.reverse
   @recipes = Recipe.paginate(page: params[:page], per_page: 4)
 end
 
 def show
  @recipe = Recipe.find(params[:id])
 end
 
 def new
  @recipe = Recipe.new
 end
 
 def create
  @recipe = Recipe.new(recipe_params)
#  @recipe.chef = Chef.find(2)
  
  if @recipe.save
   #do something
   flash[:success] = "Your Recipe was created successfully"
   redirect_to recipes_path
  else
   render :new
  end
 end
 
  def edit
    @recipe = Recipe.find(params[:id])
  end
  
  def update
   @recipe = Recipe.find(params[:id])
   if @recipe.update(recipe_params)
   #do something
   flash[:success] = "Your Recipe was updated successfully"
   redirect_to recipe_path(@recipe)
   else
    render :new
   end
  end
  
  def like
   @recipe = Recipe.find(params[:id])
   like = Like.create(like: params[:like],chef: Chef.first, recipe: @recipe)
    if like.valid?
    flash[:success] = "Your selection was successfully"
    else
    flash[:danger] = "You can only Like/Dislike a recipe Once"
    end
   redirect_to :back
  end
  
  private
   def recipe_params 
    params.require(:recipe).permit(:name, :summary, :description, :picture)
   end
end