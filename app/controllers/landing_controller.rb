class LandingController < ApplicationController
  def index
    @communities = Community.all
    render layout: "basic"
  end
end
