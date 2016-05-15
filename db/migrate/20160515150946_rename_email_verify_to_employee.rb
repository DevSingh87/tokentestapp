class RenameEmailVerifyToEmployee < ActiveRecord::Migration
  def change
  	rename_column :employees, :email_verified, :email_phone_number_verified
  end
end
