class Post < ActiveRecord::Base
  # paperclip
  has_attached_file :image, 
                    styles: {thumb: '300x300>'},
                    :storage => :s3,
                    :s3_credentials => {
                      :bucket => 'instagram_julia',
                      :access_key_id => Rails.application.secrets.aws_access_key,
                      :secret_access_key => Rails.application.secrets.aws_secret_key
                    }

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\z/

  # database associations
  belongs_to :user
  has_and_belongs_to_many :tags

  def tag_names
  end

  def tag_names=(tag_list)
    tag_list.split(', ').each do |tag|
      tags << Tag.find_or_create_by(name: tag)
      # tags << Tag.create(name: tag)
    end
  end
end
