class Video
  attr_reader :title, :thumbnails, :short_description, :_id, :description, :youtube_id
  def initialize options={}
    options.each do |k, v|
      eval("@#{k.to_s} = v")
    end
  end
end
