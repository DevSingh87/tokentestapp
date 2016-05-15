class AddEmailVerifyColumnToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :email_verified, :boolean, :default => false
    add_column :employees, :verify_token, :string
  end
end
