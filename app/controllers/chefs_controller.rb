class ChefsController < ApplicationController
  
 def index
   #@recipes = Recipe.all.sort_by{|likes| likes.thumbs_up_total}.reverse
   @chefs = Chef.paginate(page: params[:page], per_page: 3)
 end

  def new
    @chef = Chef.new
  end
  
  def create
   @chef = Chef.new(chef_params)
   if @chef.save
    flash[:success] = "Your Account has been created successfully"
    redirect_to recipes_path
   else
    render :new
   end
  end
  
  def edit
  @chef = Chef.find(params[:id])
  end
  
  def update
     @chef = Chef.find(params[:id])
   if @chef.update(chef_params)
   #do something
   flash[:success] = "Your Profile has been updated"
   redirect_to recipes_path
   else
    render :edit
   end
  end
  
  def show
   @chef = Chef.find(params[:id])
   @recipes = @chef.recipes.paginate(page: params[:page], per_page: 4)
  end
  
  private
   def chef_params 
    params.require(:chef).permit(:chefname, :email, :password)
   end
end