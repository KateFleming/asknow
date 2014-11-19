# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create communities
Community.create([
    {
        name: 'Seattle',
        latitude: 47.606209,
        longitude: -122.332071
    },
    {
        name: 'Tacoma',
        latitude: 47.252877,
        longitude: -122.444291
    },
    {
        name: 'Olympia',
        latitude: 47.037874,
        longitude: -122.900695
    }
])

# Create feeds
Feed.create({
    tag: 'trending',
    name: 'Trending'
})