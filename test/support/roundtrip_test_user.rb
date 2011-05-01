require 'capybara/rails'

module Roundtrip
  class TestUser
    module TicketReporter
      def open_ticket(summary)
        visit "/support/tickets"
        click_on "Open a new ticket"
        fill_in "Summary", :with => summary
        click_on "Open ticket"
      end
    end

    include Capybara
    include TicketReporter

    attr_reader :email, :password

    def initialize(options = {})
      @email = options[:email] || next_email
      @password = options[:password] || "s3cr3t"
    end

    def register
      visit "/users/sign_up"
      fill_in "Email", :with => @email
      fill_in "Password", :with => @password
      fill_in "Password confirmation", :with => @password
      click_on "Sign up"
    end

    def login
      visit "/users/sign_in"
      fill_in "Email", :with => @email
      fill_in "Password", :with => @password
      click_on "Sign up"
    end

    def logout
      visit "/users/sign_out"
    end

    def register_and_login
      register
    end

    def see?(*args)
      args.collect { |a| page.has_content?(a) }.all?
    end

    protected
    def next_email
      "#{ActiveSupport::SecureRandom.hex(3)}@example.com"
    end
  end
end
