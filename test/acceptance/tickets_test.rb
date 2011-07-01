require 'test_helper'

class TicketsTest < Bbq::TestCase
  scenario "user opens a ticket" do
    alice = Roundtrip::TestUser.new
    alice.roles(:ticket_reporter)
    alice.register_and_login

    summary, description = "Server is not responding", "When I hit refresh fail-whale appears."
    alice.open_ticket(summary, description)
    alice.see!(summary, description, "OPEN")
  end

  scenario "users provides more details on ticket" do
    alice = Roundtrip::TestUser.new
    alice.roles(:ticket_reporter)
    alice.register_and_login

    summary, description = "Server is not responding", "When I hit refresh fail-whale appears."
    alice.open_ticket(summary, description)

    comment = "Actually this whale looks really nice."
    alice.update_ticket(summary, comment)
    alice.see!(summary, description, comment, "OPEN")
  end

  scenario "user can browse tickets" do
    alice = Roundtrip::TestUser.new
    alice.roles(:ticket_reporter)
    alice.register_and_login

    summary, description = "Server is not responding", "When I hit refresh fail-whale appears."
    alice.open_ticket(summary, description)

    alice.open_tickets_listing
    alice.see!(summary, "OPEN")
    alice.not_see!(description)

    alice.click_on(summary)
    alice.see!(summary, description, "OPEN")
  end
end
