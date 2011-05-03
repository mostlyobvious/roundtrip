require 'test_helper'

class TicketsTest < ActionDispatch::IntegrationTest
  test "user opens a ticket" do
    alice = Roundtrip::TestUser.new
    alice.register_and_login

    summary, description = "Server is not responding", "When I hit refresh fail-whale appears."
    alice.open_ticket(summary, description)
    assert alice.see?(summary, description, "OPEN")
  end

  test "users provides more details on ticket" do
    alice = Roundtrip::TestUser.new
    alice.register_and_login

    summary, description = "Server is not responding", "When I hit refresh fail-whale appears."
    alice.open_ticket(summary, description)

    comment = "Actually this whale looks really nice."
    alice.update_ticket(summary, comment)
    assert alice.see?(summary, description, comment, "OPEN")
  end

  test "user can browse tickets" do
    alice = Roundtrip::TestUser.new
    alice.register_and_login
    summary, description = "Server is not responding", "When I hit refresh fail-whale appears."
    alice.open_ticket(summary, description)

    alice.visit "/support/tickets"
    assert alice.see?(summary, "OPEN")
    assert alice.not_see?(description)

    alice.click_on(summary)
    assert alice.see?(summary, description, "OPEN")
  end
end
