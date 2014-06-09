class User < ActiveRecord::Base
  has_many :likes

  scope :create_neo, ->(name) {
    raise 'name cannot be null' if name.nil?

    user = User.create(name: name)
    @neo = Neography::Rest.new
    node = @neo.create_node(id: user.id)
    @neo.add_label(node, 'User')
  }

  def liked_movies
    @neo = Neography::Rest.new
    movies_nodes = @neo.execute_query("MATCH (user:User {id: #{self.id} }) - [:likes] -> (movie) RETURN movie")
    movies = []
    movies_nodes["data"].each do |first_array|
      first_array.each do |second_array|
        id = second_array["data"]["id"]
        movies.append(Movie.find(id))
      end
    end
    movies
  end


end
