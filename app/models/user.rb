class User
  attr_reader :name, :email

  def initialize(user_data)
    @user_data = user_data
    if user_data
      @name = user_data['name']
      @email = user_data['email']
    end
  end

  def signed_in?
    !!user_data
  end

  private

  attr_reader :user_data
end
