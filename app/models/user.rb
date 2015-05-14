class User
  attr_reader :name, :email, :token

  def initialize(user_data = {}, token = nil)
    @user_data = user_data
    @name = user_data['name']
    @email = user_data['email']
    @token = token
  end

  def signed_in?
    token.present?
  end

  class Store
    class_attribute :users

    def self.add(user)
      self.users ||= {}
      self.users[user.token] = user
    end

    def self.fetch(token)
      (self.users && self.users[token]) || User.new
    end

    def self.remove(token)
      self.users.delete token
    end
  end

  private

  attr_reader :user_data
end
