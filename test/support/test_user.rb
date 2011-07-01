require 'bbq/devise'

module Roundtrip
  class TestUser < Bbq::TestUser
    include Bbq::Devise

    def register_and_login
      register
    end

    def update_ticket(summary, comment)
      show_ticket(summary)
      fill_in  "Comment", :with => comment
      click_on "Add update"
    end

    module TicketReporter
      def open_ticket(summary, description)
        visit support.tickets_path
        click_on "Open a new ticket"
        fill_in  "Summary", :with => summary
        fill_in  "Description", :with => description
        click_on "Open ticket"
      end

      def show_ticket(summary)
        visit support.tickets_path
        click_on summary
      end
    end

    module TicketManager
      def close_ticket(summary, comment = nil)
        visit support.admin_tickets_path
        click_on summary
        fill_in  "Comment", :with => comment if comment
        click_on "Close ticket"
      end

      def show_ticket(summary)
        visit support.admin_tickets_path
        click_on summary
      end
    end
  end
end
