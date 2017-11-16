namespace :translations do
  desc "Migrate translations of authors"
  task migrate: :environment do
    class_name = ENV['CLASS']
    raise 'Specify the class name' if class_name.blank?
    klass = class_name.constantize
    translation_klass = define_translation_class(class_name)
    id_name = "#{class_name.underscore}_id"
    conn = ActiveRecord::Base.connection
    klass.find_each do |src|
      [:en, :tw].each do |locale|
        dst = translation_klass.find_or_create_by(id_name => src.id,
                                                  :locale => locale_name(locale)) do |created|
          trace('Created', created)
        end
        params = klass.translated_attribute_names
                      .reduce({}) do |memo, attr_name|
                        val = src.send("#{attr_name}_#{locale}")
                        memo.merge!(attr_name => val)
                        memo
                      end
        dst.update(params)
        trace('Updated', dst, params)
      end
    end
  end
end

def define_translation_class(class_name)
  a_new_class = Class.new(ApplicationRecord)
  Object.const_set("#{class_name}Translation", a_new_class)
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

def trace(tag, translation, params = nil)
  puts "[#{tag}] translation: #{translation.attributes} , params: #{params}"
end
