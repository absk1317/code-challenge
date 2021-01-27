class AddCityStateToCompanies < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :city, :string, default: ''
    add_column :companies, :state, :string, default: ''

    Company.find_each do |company|
      company.send(:populate_city_state)
      company.save
    end
  end
end
