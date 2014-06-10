# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

@neo = Neography::Rest.new

u1 = User.create_neo('Grzesiek M.')
u2 = User.create_neo('Krzysiek T.')
u3 = User.create_neo('Kolega XY.')
u4 = User.create_neo('Koleżanka YX.')

m1 = Movie.create_neo('Matrix', 'Reżyser')
m2 = Movie.create_neo('Matrix 2', 'Reżyser ten sam chyba')
m3 = Movie.create_neo('Dzieci z Bullerbyn', 'AKtośTam')
m4 = Movie.create_neo('Pan Tadeusz', 'Adaptacja czyjaś')

u1.like_movie(m1.id)
u1.like_movie(m2.id)

l1 = u2.like_movie(m1.id)
l2 = u2.like_movie(m2.id)
u2.like_movie(m4.id)

u3.like_movie(m1.id)
u3.like_movie(m3.id)

u4.like_movie(m3.id)


u2.like_like(l1.id)