class Tag < ActiveRecord::Base
   has_and_belongs_to_many :posts

   # added later to ensure no duplicate tag names
   validates :name, uniqueness: true

end
