class LinksController < ApplicationController
  def index
    form Link::Index
  end

  def create
    run Link::Create do |op|
      return redirect_to created_link_path(op.model)
    end

    render :new
  end

  def show
    run Link::Show do |op|
      return redirect_to op.model.url, :status => :moved_permanently
    end

    redirect_to '/', error: 'Invalid link'
  end
end
