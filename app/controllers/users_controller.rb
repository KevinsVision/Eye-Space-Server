class UsersController < ApplicationController

  def index
    users = User.all
  end

  def show
    user = User.find_by(id: parms[:id])
    if user
      render json: user
    else
      render json: { error: 'User not found from SHOW server.' }, status: 404
    end
  end

  def create
    user = User.new(user: parms[:user])
    if user.save
      render json: user
    else
      render json: { error: "User can not generate from CREATE" }, status: 400
    end
  end

  def update
    user = User.find(parms[:id])
    user.update(user: params[:user])
    render json: user
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
  end

end
