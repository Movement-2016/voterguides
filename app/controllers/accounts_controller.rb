class AccountsController < ApplicationController
  load_and_authorize_resource class: "User"

  def show
  end
end
