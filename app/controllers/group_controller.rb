class GroupController < ApplicationController
  def new
    @group = Group.new
  end
end
