# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

@neo = Neography::Rest.new

u1 = User.create(name: 'Grzesiek M.')
u1_node = @neo.create_node(id: u1.id, name: u1.name)
u2 = User.create(name: 'Krzysiek T.')
u2_node = @neo.create_node(id: u2.id, name: u2.name)
@neo.add_label(u1_node, 'User')
@neo.add_label(u2_node, 'User')

#User.create(name: 'Krzysiek R.')
#User.create(name: 'Krzysiek Z.')
#User.create(name: 'Krzysiek E.')
#User.create(name: 'Krzysiek P.')
#User.create(name: 'Łukasz S.')

m1 = Movie.create(title: 'Matrix', director: 'Ktoś tam')
m2 = Movie.create(title: 'Matrix 2', director: 'Ktoś tam')

m1_node = @neo.create_node(id: m1.id, title: m1.title, director: m1.director)
m2_node = @neo.create_node(id: m2.id, title: m2.title, director: m2.director)

@neo.add_label(m1_node, 'Movie')
@neo.add_label(m2_node, 'Movie')

