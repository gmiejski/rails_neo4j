class User < ActiveRecord::Base
  has_many :likes

  scope :create_neo, ->(name) {
    raise 'name cannot be null' if name.nil?

    user = User.create(name: name)
    @neo = Neography::Rest.new
    node = @neo.create_node(id: user.id, name: user.name)
    @neo.add_label(node, 'User')
    user
  }

  def liked_movies
    @neo = Neography::Rest.new
    movies_nodes = @neo.execute_query("MATCH (user:User {id: #{self.id} }) - [:likes] -> (movie) RETURN movie")
    movies_ids = []
    movies_nodes["data"].each do |first_array|
      first_array.each do |second_array|
        movie_id = second_array["data"]["id"]
        movies_ids.append(movie_id)
      end
    end
    Movie.find(movies_ids)
  end

  def find_movie_friend
    @neo = Neography::Rest.new
    fiends_ids = []
    movie_friends = @neo.execute_query("MATCH p=(user:User {id: #{self.id} }) - [:likes] -> (movie) <- [:likes] - (friend) RETURN extract ( n IN nodes(p)| n.id)")
    movie_friends["data"].each do |first_array|
      fiends_ids.append(first_array[0][-1])
    end
    User.find(most_common_value(fiends_ids))
  end

  def like_movie(movie_id)
    Movie.add_like(movie_id, self.id)
  end

  def like_like(like_id)
    Like.add_like(self.id, like_id)
  end


  private
  def most_common_value(a)
    a.group_by do |e|
      e
    end.values.max_by(&:size).first
  end
end
