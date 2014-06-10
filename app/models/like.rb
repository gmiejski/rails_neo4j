class Like < ActiveRecord::Base
  belongs_to :user

  scope :add_like, ->(user_id, like_id) {
    raise 'like_id cannot be null' if like_id.nil?
    raise 'user_id cannot be null' if user_id.nil?
    like = Like.create(user_id: user_id)
    @neo = Neography::Rest.new
    like_node = @neo.create_node(id: like.id)
    @neo.add_label(like_node, 'Like')

    like_node = @neo.find_nodes_labeled('Like', {:id => like_id})
    user_node = @neo.find_nodes_labeled('User', {:id => user_id})
    raise 'user node not found' if user_node.nil?
    raise 'like node not found' if like_node.nil?
    relationship = @neo.create_relationship('likes', user_node, like_node)
    @neo.set_relationship_properties(relationship, {:id => like.id})
    like
  }

end
