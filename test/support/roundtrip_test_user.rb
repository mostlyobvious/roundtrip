require 'capybara/rails'

module Roundtrip
  class TestUser
    module TicketReporter
      def open_ticket(summary, description)
        @session.visit "/support/tickets"
        @session.click_on "Open a new ticket"
        @session.fill_in "Summary", :with => summary
        @session.fill_in "Description", :with => description
        @session.click_on "Open ticket"
      end

      def update_ticket(summary, comment)
        show_ticket(summary)
        @session.fill_in "Comment", :with => comment
        @session.click_on "Add update"
      end

      def show_ticket(summary)
        @session.visit "/support/tickets"
        @session.click_on summary
      end
    end

    module TicketManager
      def update_ticket(summary, comment)
        show_ticket(summary)
        @session.fill_in "Comment", :with => comment
        @session.click_on "Add update"
      end

      def show_ticket(summary)
        @session.visit "/support/admin/tickets"
        @session.click_on summary
      end
    end

    attr_reader :email, :password

    def initialize(options = {})
      @email = options[:email] || next_email
      @password = options[:password] || "s3cr3t"
      @session = Capybara::Session.new(Capybara.current_driver, Capybara.app)
    end

    def method_missing(method, *args)
      if Capybara::Session::DSL_METHODS.include? method.to_sym
        @session.send(method, *args)
      else
        super
      end
    end

    def register
      @session.visit "/users/sign_up"
      @session.fill_in "Email", :with => @email
      @session.fill_in "Password", :with => @password
      @session.fill_in "Password confirmation", :with => @password
      @session.click_on "Sign up"
    end

    def login
      @session.visit "/users/sign_in"
      @session.fill_in "Email", :with => @email
      @session.fill_in "Password", :with => @password
      @session.click_on "Sign in"
    end

    def logout
      @session.visit "/users/sign_out"
    end

    def register_and_login
      register
    end

    def see?(*args)
      args.collect { |a| @session.has_content?(a) }.all?
    end

    def not_see?(*args)
      args.collect { |a| @session.has_no_content?(a) }.all?
    end

    protected
    def next_email
      "#{ActiveSupport::SecureRandom.hex(3)}@example.com"
    end
  end
end
