class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :title_en
      t.string :title_tw
      t.references :author, foreign_key: true

      t.timestamps
    end
  end
end
