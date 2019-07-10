class UsersController < ApplicationController

  def index
    users = User.all
  end

  def show
    user = User.find_by(id: parms[:id])
    if user
      render json: user, include: [:user_comments, { 
        :user_comments => { 
          include: :comment, except: [:updated_at, :created_at]
           }
      }],
      except: [:updated_at, :created_at]
    else
      render json: { error: 'User not found from SHOW server.' }, status: 404
    end
  end

  def create
    user = User.new(username: params[:username], password: params[:password])
    if user.save
      render json: user
    else
      render json: {error: "Username Already Taken! from SIGNUP server"}, status: 400
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

  def signin
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      render json: { username: user.username, token: issue_token({ id: user.id }) }
    else
      render json: { error: 'Invalid username/password combination from SIGNIN server.' }, status: 401
    end
  end

  def validate
    user = current_user
    if user
      render json: { username: user.username, token: issue_token({ id: user.id }) }
    else
      render  status: 404
    end
  end

end
