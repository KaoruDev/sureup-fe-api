class User < ActiveRecord::Base
  has_many :vehicles

  before_save :create_api_key

  def create_api_key
    if self.api_key.blank?
      self.api_key = Digest::SHA1.hexdigest(SecureRandom.hex + Time.now.to_s)
      if User.find_by(api_key: self.api_key)
        self.api_key = nil
        self.create_api_key
      end
    end
  end
end
