class AddBrandColorToCompanies < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :brand_color, :string, default: '#000', null: false
  end
end
