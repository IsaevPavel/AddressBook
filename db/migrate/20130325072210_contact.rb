class Contact < ActiveRecord::Migration
  def up
    create_table :contacts do |t|
    t.column :name, :string
  end
  end

  def down
    drop_table :contacts
  end
end
