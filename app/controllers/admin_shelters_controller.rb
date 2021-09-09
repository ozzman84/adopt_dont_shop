class AdminSheltersController < ApplicationController
  def index
    @admin_s = Shelter.all.reverse_alfa_name
    @admin_s_pending_apps = Shelter.all.with_pending_apps
  end

  def show
    @admin_s = Shelter.find(params[:id])
  end
end
