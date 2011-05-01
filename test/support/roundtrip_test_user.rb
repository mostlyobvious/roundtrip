require 'capybara'

module Roundtrip
  class TestUser
    include Capybara

    def initialize(email, password = "s3cr3t")
      @email, @password = email, password
    end

    def register
      visit("/users/sign_up")
      fill_in "Email", :with => @email
      fill_in "Password", :with => @password
      fill_in "Password confirmation", :with => @password
    end

    def login
      visit("/users/sign_in")
      fill_in "Email", :with => @email
      fill_in "Password", :with => @password
    end

    def logout
      visit("/users/sign_out")
    end

    def register_and_login
      register
    end
  end
end
