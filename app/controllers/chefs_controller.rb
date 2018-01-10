class ChefsController < ApplicationController
  before_action :set_chef, only: [:show, :edit, :update]
  
  def new
    @chef = Chef.new
  end

  def create
    # debugger
    @chef = Chef.new(chef_params)
    if @chef.save
        flash[:success] = "Welcome #{@chef.name} to the recipe application!"
        redirect_to chef_path(@chef)
    else
        render :new
    end
  end
  
  def show
  end
  
  def edit
  end

  def update
    if @chef.update(chef_params)
      flash[:success] = 'Your accound has been updated successfully!'
      redirect_to @chef # short form to show
    else
        render :edit
    end
  end
  
  private 
    def set_chef
        @chef = Chef.find(params[:id])
    end

    def chef_params
        params.require(:chef).permit(:name, :email, :password, :password_confirmation)
    end
    
end