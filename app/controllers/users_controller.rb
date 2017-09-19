class UsersController < ApplicationController
  def spotify
      redirect_to '/'
    end
# TODO: may need to check out the logic for update token...
  # def update_token
  #   if params[:code]
  #     current_user.get_spotify_token!(params[:code])
  #     flash[:notice] = "Now that we're authenticated, you can share that playlist!"
  #     redirect_to playlists_path
  #   else
  #     flash[:alert] = "Cannot share playlist without spotify account access."
  #     redirect_to :root
  #   end
  # end
end
