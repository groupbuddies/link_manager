class LinksController < ApplicationController
  skip_before_action :require_login, only: :show

  def index
    form Link::Create
    @links = Link::Index.(link_params)
  end

  def create
    run Link::Create, link_params do |op|
      @new_link = op.model
    end

    @links = Link::Index.(link_params)
    render :index
  end

  def show
    run Link::Show, params.merge(user_agent: request.user_agent) do |op|
      return redirect_to op.model.url, :status => :moved_permanently
    end

    redirect_to '/', error: 'Invalid link'
  end

  private

  def link_params
    params.merge(user_email: current_user.email)
  end
end
