class DeleteUserFields < ActiveRecord::Migration
  def change
      %w( uid provider name token secret ).each do |column|
        remove_column :users, column
      end
  end
end
