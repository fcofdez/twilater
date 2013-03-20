class DeleteUserFields < ActiveRecord::Migration
  def change


    # Migrating user to multiaccount
    User.find_each do |user|
      identity = Identity.create!(uid: user.uid,
                                  provider: user.provider,
                                  nickname: user.name,
                                  token: user.token,
                                  secret: user.secret,
                                  user_id: user.id)
      # Temporaly change values of identity to user_id before rename it
      Contents.where(user_id: user.id).update_all user_id: identity.id
    end

    rename_column :contents, :user_id, :identity_id

    %w( uid provider name token secret ).each do |column|
      remove_column :users, column
    end
  end
end
