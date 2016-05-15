class ChangeLimitPhoneNumberEmployee < ActiveRecord::Migration
  def change
  	change_column :employees, :phone_number, :integer, :limit => 8
  end
end
