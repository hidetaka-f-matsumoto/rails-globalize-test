class Book < ApplicationRecord
  translates :title
  belongs_to :author
end
