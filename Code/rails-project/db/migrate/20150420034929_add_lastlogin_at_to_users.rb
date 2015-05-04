class AddLastloginAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :lastlogin_at, :datetime
  end
end
