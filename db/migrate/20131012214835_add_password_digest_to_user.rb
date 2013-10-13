class AddPasswordDigestToUser < ActiveRecord::Migration
  def change
    add_column :password_digest, :string
  end
end
