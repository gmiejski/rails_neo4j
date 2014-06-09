class User < ActiveRecord::Base
  has_many :likes

  scope :create_neo, ->(name) {
    raise 'name cannot be null' if name.nil?

    user = User.create(name: name)
    @neo = Neography::Rest.new
    node = @neo.create_node(id: user.id)
    @neo.add_label(node, 'User')
  }

end
