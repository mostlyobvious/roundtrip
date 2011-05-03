module Roundtrip
  class Ticket < ActiveRecord::Base
    include ActiveRecord::Transitions

    belongs_to :reporter, :class_name => "::User"
    has_many :comments

    validates :reporter, :presence => true
    validates :summary,  :presence => true, :length => {:maximum => 200}
    validates :state,    :presence => true

    attr_protected :reporter_id, :state

    accepts_nested_attributes_for :comments #, :reject_if => lambda { |c| c[:content].blank? }

    state_machine do
      state :open
    end
  end
end
