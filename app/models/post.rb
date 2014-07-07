class Post < ActiveRecord::Base
  has_attached_file :image, 
                    styles: {thumb: '300x300>'},
                    :storage => :s3,
                    :s3_credentials => {
                      :bucket => 'instagram_julia',
                      :access_key_id => Rails.application.secrets.aws_access_key,
                      :secret_access_key => Rails.application.secrets.aws_secret_key
                    }

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\z/

end
