class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    friend = User.find(params[:friend_id])
    params[:user_id] = current_user.id

    Friendship.create(friendship_params) unless current_user.follows_or_same?(friend)
    redirect_to root_url
  end

  def show
    @friend = Friendship.find(params[:id]).friend
    @exercises = @friend.exercises
  end


  def destroy
    @friendship = Friendship.find(params[:id])
    friend_name = @friendship.friend.full_name

    if @friendship.destroy
      flash[:notice] = "#{friend_name} unfollowed"
    else
      flash.now[:alert] = "#{friend_name} could not be unfollowed"
    end

    redirect_to user_exercises_path(current_user)
  end

  private

  def friendship_params
    params.permit(:user_id, :friend_id)
  end
end
