class Number < ActiveRecord::Migration
  def up
    create_table :numbers do |t|
      t.column :name, :string
      t.column :number_type, :string
      t.column :contact_id, :integer
    end

  end

  def down
    drop_table :numbers
  end
end
