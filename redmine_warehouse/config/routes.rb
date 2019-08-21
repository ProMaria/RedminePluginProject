# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

resources :products
get 'projects/:project_id/products', :to => 'products#index', :as => 'project_products'
get 'projects/:project_id/products/new', :to => 'products#new', :as => 'new_project_product'
get 'projects/:project_id/products/:id', :to => 'products#show', :as => 'project_product'
get 'projects/:project_id/products/:id/edit', :to => 'products#edit', :as => 'edit_project_product'
post 'projects/:project_id/products', :to => 'products#create'

