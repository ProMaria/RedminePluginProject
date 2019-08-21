class ProductsController < ApplicationController
  default_search_scope :products
  helper ProductsHelper
  include QueriesHelper
  before_action :authorize, :only => [:new] 
  before_action :find_project, :authorize
  before_action :find_product,:authorize, :only => [:show, :edit, :update, :destroy]
  before_action :build_new_product_from_params, :only => [ :edit]
  
  def index  	
  	@products = RedmineWarehouseProduct.all    
  end

  def show 
      
  end

 def new    
    @product = RedmineWarehouseProduct.new
    build_new_product_from_params 
    respond_to do |format|
      format.html { render :action => 'new', :layout => !request.xhr?}
      format.js
    end
  end

  def create
    @product = RedmineWarehouseProduct.new
    build_new_product_from_params 
    if @product.save
      redirect_to project_product_path(id: @product.id, project_id: params[:project_id])
      respond_to do |format|
        format.html {
          flash[:notice] = l(:notice_product_successful_create, :name => view_context.link_to("#{@product.name}", project_product_path(id: @product.id, project_id: params[:project_id]), :title => @product.name))
        }
        
      end
      return
    else
      respond_to do |format|
        format.html {
          if @product.nil?
            render_error :status => 422
          else
            render :action => 'new'
          end
        }
        
      end
    end
  end

  def edit

  end

  def update
    @product = RedmineWarehouseProduct.find(params[:id]) 
    build_new_product_from_params   
    
    if @product.save         
      flash[:notice] = l(:notice_product_successful_update, :name => view_context.link_to("#{@product.name}", project_product_path(id: @product.id, project_id: params[:project_id]), :title => @product.name))
      redirect_to project_product_path(id: @product.id, project_id: params[:project_id])
    else
      render :action => 'edit'
    end
  end

  def destroy 
    puts 'PRODUCT_ID'
    puts @product.id    
    if @product.destroy
      flash[:notice] = l(:notice_product_successful_destroy)
    end
    puts 'DESTROYED'
    redirect_to project_products_path(params[:project_id])
  end

  private

  def find_project
    @project = Project.find(params[:project_id])
  end

  def build_new_product_from_params

    @issues = @project.issues    
    @attrs = (params[:redmine_warehouse_product] || {}).deep_dup
    if @attrs.present?
      @product.name = @attrs[:name]
      @product.quantity = @attrs[:quantity]
      @product.cost = @attrs[:cost]
      @product.manufacture_date = @attrs[:manufacture_date]
      @product.issue_id = @attrs[:issue_id]
    end
  end

  # Redirects user after a successful product creation
  def redirect_after_create
    redirect_to project_products_path(params[:project_id])    
  end

 

  def find_product
    @product = RedmineWarehouseProduct.find(params[:id])   
  rescue ActiveRecord::RecordNotFound
    render_404
  end

end
