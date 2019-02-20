class Api::V1::MoviesController < ApplicationController
    respond_to :json
    include DeviseTokenAuth::Concerns::SetUserByToken

    protect_from_forgery with: :null_session, only: Proc.new { |c| c.request.format.json? }  
    before_action :authenticate_user!

    def index
        @movies = Movie.all
        render json: @movies
    end

    private

    def movie_params
        params.require(:movie).permit(:name, :poster, :synopsis, :release, :trailer)
    end

end
