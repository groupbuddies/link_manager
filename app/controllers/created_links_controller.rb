class CreatedLinksController < ApplicationController
  def show
    present Link::ShowCreated
  end
end
