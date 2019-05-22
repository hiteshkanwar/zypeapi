module Zype
  class Videos < BaseClass
    def initialize options={}
      @video_id = options[:video_id]
    end

    def fetch_list(per_page: 12, page: 1)
      rest_api(:get, 'videos', {params: {per_page: per_page, page: page}}.compact)
    end

    def fetch_video
      rest_api(:get, "videos/#{@video_id}")
    end
  end
end
