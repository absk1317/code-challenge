class AddCityStateToCompanies < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :city, :string, default: ''
    add_column :companies, :state, :string, default: ''
  end
end
