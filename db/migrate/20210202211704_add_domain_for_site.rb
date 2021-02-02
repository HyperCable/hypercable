class AddDomainForSite < ActiveRecord::Migration[6.1]
  def change
    add_column :sites, :domain, :string
  end
end
