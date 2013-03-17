class ChangeDataTypeToTweetId < ActiveRecord::Migration
  def change
    change_column :contents, :tweet_id, :bigint
  end
end
