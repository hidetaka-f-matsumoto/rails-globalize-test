namespace :translations do
  desc "Migrate translations of authors"
  task migrate: :environment do
    class_name = ENV['CLASS']
    raise 'Specify the class name' if class_name.blank?
    klass = class_name.constantize
    translation_klass = define_class("#{class_name}Translation")
    id_name = "#{class_name.underscore}_id"
    conn = ActiveRecord::Base.connection
    klass.find_each do |obj|
      [:en, :tw].each do |locale|
        init = { id_name => obj.id, :locale => locale_name(locale) }
        params = klass.translated_attribute_names
                      .reduce(init) do |memo, attr_name|
                        val = obj.send("#{attr_name}_#{locale}")
                        memo.merge!(attr_name => val)
                        memo
                      end
        translation_klass.create(params)
      end
    end
  end
end

def define_class(class_name)
  a_new_class = Class.new(ApplicationRecord)
  Object.const_set(class_name, a_new_class)
end

def locale_name(locale)
  case locale
  when :en
    'en'
  when :tw
    'zh-TW'
  else
    raise 'Unsupported locale'
  end
end
