module Roundtrip
  class TicketsController < ApplicationController
    respond_to :html

    def index
      respond_with(@tickets = current_user.tickets.all)
    end

    def show
      respond_with(@ticket = current_user.tickets.find(params[:id]))
    end

    def new
      respond_with(@ticket = current_user.tickets.build)
    end

    def create
      @ticket = current_user.tickets.create(params[:ticket])
      @ticket.reporter = current_user

      respond_with(@ticket)
    end
  end
end
