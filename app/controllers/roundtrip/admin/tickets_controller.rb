module Roundtrip
  class Admin::TicketsController < AdminController
    def index
      @tickets = Ticket.all
    end

    def show
      @ticket = Ticket.find(params[:id])
    end
  end
end
