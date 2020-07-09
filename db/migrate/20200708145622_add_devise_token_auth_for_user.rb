class AddDeviseTokenAuthForUser < ActiveRecord::Migration[6.0]
  def up
    change_table :users do |t|
      t.string :provider, null: false, default: 'email'
      t.string :uid, null: false, default: ''
      t.json :tokens
    end

    User.reset_column_information
    User.find_each do |u|
      u.uid = u.email
      u.name = u.name
      u.provider = 'email'   # is this necessary?
      u.save!
    end

    add_index :users, [:uid, :provider], unique: true
  end

  def down
    remove_columns :user, :provider, :uid, :tokens
    remove_index :user, name: :index_users_on_uid_and_provider
  end
end
