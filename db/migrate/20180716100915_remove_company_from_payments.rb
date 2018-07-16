class RemoveCompanyFromPayments < ActiveRecord::Migration
  def change
    remove_column :payments, :company, :string
  end
end
