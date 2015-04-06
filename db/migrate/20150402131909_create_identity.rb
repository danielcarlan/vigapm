class CreateIdentity < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.belongs_to :user, index: true
      t.string :uid
      t.string :provider
    end
  end
end
