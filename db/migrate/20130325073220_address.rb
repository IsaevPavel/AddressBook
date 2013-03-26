class Address < ActiveRecord::Migration
  def up
    create_table :addresses do |t|
      t.column :name, :string
      t.column :address_type, :string
      t.column :contact_id, :integer
    end

  end

  def down
    drop_table :addresses
  end
end
