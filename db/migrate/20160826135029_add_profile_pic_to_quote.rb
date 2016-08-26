class AddProfilePicToQuote < ActiveRecord::Migration
  def change
    add_column :quotes, :profile_pic, :string
  end
end
