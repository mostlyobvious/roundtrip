module Roundtrip
  class Comment < ActiveRecord::Base
    belongs_to :author, :class_name => "::User"
    belongs_to :ticket, :touch => true

    validates :description, :presence => true
    validates :author,      :presence => true

    attr_protected :author_id
  end
end
