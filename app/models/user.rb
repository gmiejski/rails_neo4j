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

  def find_movie_friend
    @neo = Neography::Rest.new
    fiends_ids = []
    movie_friends = @neo.execute_query("MATCH p=(user:User {id: #{self.id} }) - [:likes] -> (movie) <- [:likes] - (friend) RETURN extract ( n IN nodes(p)| n.id)")
    movie_friends["data"].each do |first_array|
      fiends_ids.append(first_array[0][-1])
    end
    User.find(most_common_value(fiends_ids))
  end

  private
  def most_common_value(a)
    a.group_by do |e|
      e
    end.values.max_by(&:size).first
  end


end
