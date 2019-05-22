class VideosController < ApplicationController
  def index
    @videos = ::Zype::Videos.new.fetch_list(page: params[:page])
    @pagination = @videos['pagination']
    @videos = @videos['response'].map{|vid| Video.new(vid)}
  end

  def show
    @video = ::Zype::Videos.new(video_id: params[:id]).fetch_video
    @video = Video.new(@video['response'])
  end
end
