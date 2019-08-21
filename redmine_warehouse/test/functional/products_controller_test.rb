require File.expand_path('../../test_helper', __FILE__)

class ProductsControllerTest < ActionController::TestCase
  test "should get index only with project_id" do
    get :index, params: {project_id: 1}
    assert_response :success
    assert_template 'index'
  end

  test "should get error without project_id" do    
    assert_raises(ActiveRecord::RecordNotFound) do
      get :index, params: {project_id: nil}
    end
  end

  test "should create product with name and params project_id" do  
    post :create, params: {redmine_warehouse_product: {name: 'Some title'}, project_id: 1}
    assert_redirected_to project_product_path(project_id: 1, id: RedmineWarehouseProduct.last.id)
  end

  test "renders product_missing page" do
    get :show, params: {id: 1234, project_id: 1}
    assert_response :not_found   
  end
end
