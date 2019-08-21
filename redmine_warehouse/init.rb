Redmine::Plugin.register :redmine_warehouse do
  name 'Redmine Warehouse plugin'
  author 'ProMaria'
  description 'Plugin adds tab Warehouse to project. Tab consists list of products'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'

  project_module :products do
    permission :index_products, :products => [:index, :show]
    permission :create_products, :products => [:create, :new, :edit, :update, :destroy]
  end

  menu :project_menu, :products, { :controller => 'products', :action => 'index'}, :last => true, :param => :project_id, :caption => 'Товары на складе'
  require_dependency 'products_hook_listener'
end
