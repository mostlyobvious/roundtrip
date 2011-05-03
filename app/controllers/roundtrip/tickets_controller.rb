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
      @ticket = current_user.tickets.build
      @ticket.comments.build
      respond_with(@ticket)
    end

    def create
      @ticket = current_user.tickets.build(params[:ticket])
      @ticket.reporter = current_user
      @ticket.comments.first.author = current_user
      @ticket.save
      respond_with(@ticket)
    end
  end
end
