module Roundtrip
  class Comment < ActiveRecord::Base
    belongs_to :author, :class_name => "::User"
    belongs_to :ticket, :touch => true

    validates :description, :presence => true
    validates :author,      :presence => true
    validates :ticket,      :presence => true, :updatable => true, :unless => :new_ticket

    attr_protected :author_id

    attr_accessor :new_ticket
  end
end
