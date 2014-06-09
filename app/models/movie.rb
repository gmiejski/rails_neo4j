class Movie < ActiveRecord::Base

  scope :create_neo, ->(title, director) {
    movie = Movie.create(title: title, director: director)
    @neo = Neography::Rest.new
    node = @neo.create_node(id: movie.id, title: movie.title, director: movie.director)
    @neo.add_label(node, 'Movie')
  }

  scope :add_like, ->(movie_id, user_id) {
    raise 'user_id cannot be null' if user_id.nil?
    raise 'movie_id cannot be null' if movie_id.nil?
    like = Like.create(user_id: user_id)
    @neo = Neography::Rest.new
    like_node = @neo.create_node(id: like.id)
    @neo.add_label(like_node, 'Like')

    movie_node = @neo.find_nodes_labeled('Movie', {:id => movie_id})
    user_node = @neo.find_nodes_labeled('User', {:id => user_id})
    raise 'user node not found' if user_node.nil?
    raise 'movie node not found' if user_node.nil?
    relationship = @neo.create_relationship('likes', user_node, movie_node)
    @neo.set_relationship_properties(relationship, {:id => like.id})
  }

  def add_like (user_id)
    raise 'user_id cannot be null' if user_id.nil?
    like = Like.create(user_id: user_id)
    @neo = Neography::Rest.new
    like_node = @neo.create_node(id: like.id)
    @neo.add_label(like_node, 'Like')

    movie_node = @neo.find_nodes_labeled('Movie', {:id => self.id})
    user_node = @neo.find_nodes_labeled('User', {:id => user_id})
    raise 'user node not found' if user_node.nil?
    raise 'movie node not found' if user_node.nil?
    relationship = @neo.create_relationship('likes', user_node, movie_node)
    @neo.set_relationship_properties(relationship, {:id => like.id})
  end

  def likers
    puts 'getting likes from movie'

  end


end
