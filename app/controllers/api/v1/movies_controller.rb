class Api::V1::MoviesController < ApplicationController
    respond_to :json
    # include DeviseTokenAuth::Concerns::SetUserByToken

    # protect_from_forgery with: :null_session, only: Proc.new { |c| c.request.format.json? }  
    # before_action :authenticate_user!

    def index
        offset = params[:page].to_i*params[:limit].to_i - params[:limit].to_i + 1
        limit = params[:page].to_i*params[:limit].to_i

        @movies = Movie.find_in_batches(start: offset, finish: limit)

        render json: @movies
    end

    private

    def movie_params
        params.require(:movie).permit(:name, :poster, :synopsis, :release, :trailer)
    end

end
