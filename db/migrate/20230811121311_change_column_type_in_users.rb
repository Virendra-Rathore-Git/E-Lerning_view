class ChangeColumnTypeInUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :mobile, :string
  end
end
