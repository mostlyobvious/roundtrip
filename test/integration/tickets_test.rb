class TicketsTest < ActionDispatch::IntegrationTest
  test "user opens a ticket" do
    alice = Roundtrip::TestUser.new

    alice.register_and_login
    summary, status = "Server is not responding", "OPEN"
    alice.open_ticket(summary)
    assert alice.see?(summary, status)
  end
end
