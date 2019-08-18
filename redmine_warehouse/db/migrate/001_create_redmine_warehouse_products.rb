class CreateRedmineWarehouseProducts < ActiveRecord::Migration[5.2]
  def self.up
    create_table :redmine_warehouse_products do |t|
      t.column :name, :string, :uniq => true
      t.column :cost, :integer
      t.column :quantity, :integer
      t.column :manufacture_date, :date
      t.column :issue_id, :integer, :null => false            
    end
    add_index :redmine_warehouse_products, :issue_id 
    add_reference :issues, :redmine_warehouse_products, foreign_key: true   
  end
end
