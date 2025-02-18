class ApplicationsController < ApplicationController
  def new
    @app = Application.new
  end

  def create
    @app = Application.new(update_app_params.merge({status: "In Progress"}))
    if @app.save
      flash[:success] = "Application Created!"
      redirect_to "/applications/#{@app.id}"
    else
      flash[:danger] = 'You must fill in all fields.'
      redirect_to "/applications/new"
    end
  end

  def update
    @app = Application.find(params[:id])
    if @app.update(update_app_params.merge({status: "Pending"}))
      redirect_to "/applications/#{@app.id}"
      flash[:success] = "Application submitted: Status is Pending!"
    else
      redirect_to "/applications/#{@app.id}"
      flash[:danger] = "Must submit reason for ownership!"
    end
  end

  def show
    @app = Application.find(params[:id])
    if params[:search].present?
      @pets = Pet.search(params[:search])
    else
      @pets = @app.pets
    end
  end

  private

  def update_app_params
    params.require(:application).permit(:name, :street_address, :city, :state, :zip_code, :description, :status)
  end
end
