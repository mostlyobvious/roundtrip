module Roundtrip
  class Admin::CommentsController < AdminController
    respond_to :html

    def create
      @ticket = Ticket.find(params[:ticket_id])
      @comment = @ticket.comments.build(params[:comment])
      @comment.author = current_user
      @comment.save
      @ticket.close! if params[:_close]
      respond_with(@comment) do |format|
        format.html { redirect_to admin_ticket_path(@comment.ticket) }
      end
    end
  end
end
