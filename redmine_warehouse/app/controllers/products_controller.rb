class ProductsController < ApplicationController
  before_action :find_project, :authorize, :only => :index
  
  def index  	
  	@products = RedmineWarehouseProduct.all
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def find_project
    # @project variable must be set before calling the authorize filter
    @project = Project.find(params[:project_id])
  end
end
