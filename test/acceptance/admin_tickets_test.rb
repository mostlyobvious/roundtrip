require 'test_helper'

class AdminTicketsTest < Bbq::TestCase
  background do
    admin = Factory(:admin)
    @email, @password = admin.email, admin.password
  end

  scenario "admin can browse all user tickets" do
    summaries    = ["Forgot my password", "Page is not displayed correctly"]
    descriptions = ["I lost my yellow note with password under the table!",
                    "My IE renders crap instead of crispy fonts!"]

    alice = Roundtrip::TestUser.new
    alice.roles(:ticket_reporter)
    alice.register_and_login
    alice.open_ticket(summaries.first, descriptions.first)

    bob = Roundtrip::TestUser.new
    bob.roles(:ticket_reporter)
    bob.register_and_login
    bob.open_ticket(summaries.second, descriptions.second)

    charlie = Roundtrip::TestUser.new(:email => @email, :password => @password)
    charlie.login # charlie was already "registered" in factory as admin
    charlie.roles(:ticket_manager)
    charlie.open_tickets_listing
    charlie.see!(*summaries)

    charlie.click_on(summaries.second)
    charlie.see!(summaries.second, descriptions.second)
    charlie.not_see!(summaries.first, descriptions.first)
  end

  scenario "admin can comment user ticket" do
    summary     = "Can't delete ticket"
    description = "Where can I find delete button for my ticket?"

    cindy = Roundtrip::TestUser.new
    cindy.roles(:ticket_reporter)
    cindy.register_and_login
    cindy.open_ticket(summary, description)

    eve = Roundtrip::TestUser.new(:email => @email, :password => @password)
    eve.roles(:ticket_manager)
    eve.login

    comment = "You won't find it. It's not a bug, it's a feature."
    eve.update_ticket(summary, comment)
    eve.see!(summary, description, comment)

    cindy.show_ticket(summary)
    cindy.see!(summary, description, comment)
  end

  scenario "admin can close ticket" do
    summary, description = "Fuuuuu", "Not working!!!!!!1"
    alice = Roundtrip::TestUser.new
    alice.roles(:ticket_reporter)
    alice.register_and_login
    alice.open_ticket(summary, description)

    barney = Roundtrip::TestUser.new(:email => @email, :password => @password)
    barney.roles(:ticket_manager)
    barney.login

    comment = "SOA #1"
    barney.close_ticket(summary, comment)
    barney.see!(summary, description, comment)

    alice.show_ticket(summary)
    alice.see!(summary, description, comment)
  end
end
