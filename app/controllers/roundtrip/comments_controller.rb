module Roundtrip
  class CommentsController < ApplicationController
    respond_to :html

    def create
      @ticket = current_user.tickets.find(params[:ticket_id])
      @comment = @ticket.comments.build(params[:comment])
      @comment.author = current_user
      @comment.save
      respond_with(@comment) do |format|
        format.html { redirect_to @comment.ticket }
      end
    end
  end
end
