class Post < ActiveRecord::Base
  # paperclip
  has_attached_file :image, 
                    styles: {thumb: '300x300>'}, # > is to take the max of either height or width
                    :storage => :s3,
                    :s3_credentials => {
                      :bucket => 'instagram_julia',
                      :access_key_id => Rails.application.secrets.aws_access_key,
                      :secret_access_key => Rails.application.secrets.aws_secret_key
                    }

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\z/
  validates :presence, :title, :description, presence: true

  # database associations
  belongs_to :user
  has_and_belongs_to_many :tags

  def tag_names
    # used later when we can edit posts
    # tags.map(&:name).join(', ')
  end

  def tag_names=(tag_list)
    return nil if tag_names == ''
    tag_list.split(/,\s?/).uniq.each do |tag|
      formatted_name = '#'+tag.delete('#')
      tags << Tag.find_or_create_by(name: formatted_name)
      # tags << Tag.create(name: tag)
    end
  end
end
