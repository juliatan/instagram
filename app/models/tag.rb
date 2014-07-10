class Tag < ActiveRecord::Base
   has_and_belongs_to_many :posts

   # added later to ensure no duplicate tag names
   validates :name, uniqueness: true

   # used to construct a URL where instead of using an ID, the tag name is used
   def to_param
    # default would be id
    name.delete('#')
   end
end
