class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :isbn
      t.string :name
      t.string :author
      t.integer :publishing_year
      t.string :publisher
      t.float :price

      t.timestamps
    end
  end
end
