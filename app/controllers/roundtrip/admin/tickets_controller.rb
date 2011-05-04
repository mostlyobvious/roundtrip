module Roundtrip
  class Admin::TicketsController < AdminController
    def index
      @tickets = Ticket.all
    end

    def show
      @ticket = Ticket.find(params[:id])
    end

    def close
      @ticket = Ticket.find(params[:id])
      redirect_to admin_ticket_path(@ticket)
    end
  end
end
