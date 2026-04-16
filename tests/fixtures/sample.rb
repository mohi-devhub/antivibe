require 'json'
require 'net/http'

module UserManagement
  class User
    attr_accessor :id, :name, :email

    def initialize(id:, name:, email:)
      @id = id
      @name = name
      @email = email
    end

    def display_name
      "#{name} <#{email}>"
    end
  end

  class UserRepository
    def find_by_id(id)
      # lookup
    end

    def create(attrs)
      User.new(**attrs)
    end
  end
end

def validate_email(email)
  email.match?(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i)
end
