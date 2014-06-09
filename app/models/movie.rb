class Movie < ActiveRecord::Base

  scope :create_neo, ->(title, director) do
    movie = Movie.create(title: title, director: director)
    @neo = Neography::Rest.new
    node = @neo.create_node(id: movie.id, title: movie.title, director: movie.director)
    @neo.add_label(node, 'Movie')
  end

  scope :add_like, ->(user_id) do
    raise 'user_id cannot be null' if user_id.nil?
    like = Like.create(user_id: user_id)
    @neo = Neography::Rest.new
    movie_node = @neo.find_nodes_labeled('Movie', {:id => self.id})
    user_node = @neo.find_nodes_labeled('User', {:id => user_id})
    raise 'user node not found' if user_node.nil?
    raise 'movie node not found' if user_node.nil?
    node = @neo.create_relationship('likes', movie_node, user_node)

  end

  def likers
    puts 'getting likes from movie'

  end


end
