require 'test_helper'

class AdminTicketsTest < ActionDispatch::IntegrationTest
  def setup
    # XXX: how to workaround it?
    @email, @password = "admin@bofh.org.pl", "potrzebie"
    @user = User.create!(:email => @email, :password => @password, :password_confirmation => @passwor)
  end

  test "admin can browse all user tickets" do
    summaries = ["Forgot my password", "Page is not displayed correctly"]
    descriptions = ["I lost my yellow note with password under the table!", "My IE renders crap instead of crispy fonts!"]

    alice = Roundtrip::TestUser.new
    alice.extend(Roundtrip::TestUser::TicketReporter)
    alice.register_and_login
    alice.open_ticket(summaries.first, descriptions.first)

    bob = Roundtrip::TestUser.new
    bob.extend(Roundtrip::TestUser::TicketReporter)
    bob.register_and_login
    bob.open_ticket(summaries.second, descriptions.second)

    bofh = Roundtrip::TestUser.new(:email => @email, :password => @password)
    bofh.extend(Roundtrip::TestUser::TicketManager)
    bofh.login
    bofh.visit "/support/admin/tickets"
    assert bofh.see?(*summaries)
    bofh.click_on(summaries.second)
    assert bofh.see?(summaries.second, descriptions.second)
    assert bofh.not_see?(summaries.first, descriptions.first)
  end

  test "admin can comment user ticket" do
    summary, description = "Can't delete ticket", "Where can I find delete button for my ticket?"
    cindy = Roundtrip::TestUser.new
    cindy.extend(Roundtrip::TestUser::TicketReporter)
    cindy.register_and_login
    cindy.open_ticket(summary, description)

    bofh = Roundtrip::TestUser.new(:email => @email, :password => @password)
    bofh.extend(Roundtrip::TestUser::TicketManager)
    bofh.login
    comment = "You won't find it. It's not a bug, it's a feture."
    bofh.update_ticket(summary, comment)
    assert bofh.see?(summary, description, comment)

    cindy.show_ticket(summary)
    assert cindy.see?(summary, description, comment)
  end
end
