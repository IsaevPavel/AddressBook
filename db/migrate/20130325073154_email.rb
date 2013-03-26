class Email < ActiveRecord::Migration
  def up
    create_table :emails do |t|
      t.column :name, :string
      t.column :email_type, :string
      t.column :contact_id, :integer
    end

  end

  def down
    drop_table :emails
  end
end
