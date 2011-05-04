module Roundtrip
  class AdminController < ApplicationController
    before_filter :require_admin

    protected
    def require_admin
      redirect_to root_path unless current_user.is_admin?
    end
  end
end
