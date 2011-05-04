require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test "new comments are invalid for closed ticket" do
    ticket = Factory(:ticket)
    first = ticket.comments.build(:author => ticket.reporter, :description => "help!")
    assert first.valid?
    first.save!
    ticket.close!
    assert first.valid?
    second = ticket.comments.build(:author => ticket.reporter, :description => "help!!!!!1")
    assert !second.valid?
  end
end
