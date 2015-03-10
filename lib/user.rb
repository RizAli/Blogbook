require 'bcrypt'
class User

  include DataMapper::Resource

  property :id, Serial
  property :username, String, :unique => true
  property :name, String
  property :email, String
  property :password_digest, Text

  def password=(password)
    self.password_digest = Bcrypt::Password.create(password)
  end

end
