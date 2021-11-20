# frozen_string_literal: true

class UsersController < ApplicationController
  # before_action :authenticate_user_using_x_auth_token, only: %i[index]

  def index
    users = User.select(:id, :name)
    render status: :ok, json: { users: users }
  end
end
