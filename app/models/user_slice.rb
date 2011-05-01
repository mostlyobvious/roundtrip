User.has_many :tickets, :class_name => "::Roundtrip::Ticket", :foreign_key => "reporter_id"
