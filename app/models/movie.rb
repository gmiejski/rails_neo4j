class Movie < ActiveRecord::Base

  scope :create_neo, ->(title, director) do
    movie = Movie.create(title: title, director: director)
    @neo = Neography::Rest.new
    @neo.create_node('id' => movie.id, title: movie.title, director: movie.director)
  end

  scope :add_like, ->(user_id) do
    return if user_id.nil?
    like = Like.create(user_id: user_id)
    @neo = Neography::Rest.new
    #node1 = @neo.create_node(id=)
  end

  def likers
    puts 'getting likes from movie'

  end


end
