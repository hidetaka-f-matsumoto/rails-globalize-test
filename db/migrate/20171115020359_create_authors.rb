class CreateAuthors < ActiveRecord::Migration[5.1]
  def change
    create_table :authors do |t|
      t.string :name
      t.string :name_en
      t.string :name_tw

      t.timestamps
    end
  end
end
