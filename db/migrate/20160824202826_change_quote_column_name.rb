class ChangeQuoteColumnName < ActiveRecord::Migration
  def change
    rename_column :quotes, :author, :user_name
  end
end
