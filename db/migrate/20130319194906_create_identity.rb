class CreateIdentity < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.string :uid
      t.string :provider
      t.string :nickname
      t.string :token
      t.string :secret
      t.references :user
    end

    add_index :identities, :user_id
  end
end
