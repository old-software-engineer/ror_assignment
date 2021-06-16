class AddFieldsInAdminUser < ActiveRecord::Migration[6.0]
  def change
    add_column :admin_users, :age, :integer, after: :name
    add_column :admin_users, :address, :string, after: :age
    add_column :admin_users, :phone, :string, after: :address
  end
end
