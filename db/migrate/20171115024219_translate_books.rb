class TranslateBooks < ActiveRecord::Migration[5.1]
  def self.up
    I18n.with_locale(:ja) do
      Book.create_translation_table!({
        :title => :string
      }, {
        :migrate_data => true,
        # :remove_source_columns => true
      })
    end
  end

  def self.down
    I18n.with_locale(:ja) do
      Book.drop_translation_table! :migrate_data => true
    end
  end
end
