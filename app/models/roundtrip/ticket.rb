module Roundtrip
  class Ticket < ActiveRecord::Base
    include ActiveRecord::Transitions

    belongs_to :reporter, :class_name => "::User"

    validates :reporter, :presence => true
    validates :summary,  :presence => true, :length => {:maximum => 200}
    validates :state,    :presence => true

    attr_protected :reporter_id, :state

    state_machine do
      state :open
    end
  end
end
