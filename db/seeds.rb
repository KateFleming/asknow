# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
GroupMemberPermission.create([
  {
    id: 1,
    name: "powerizer",
    powers: "can invite other members",
    read: true,
    write: true,
    invite: true,
    remove: true
  },{
    id: 2,
    name: "particpator",
    powers: "can post",
    read: true,
    write: true,
    invite: true,
    remove: false
  },{
    id: 3,
    name: "propector",
    powers: "can only watch",
    read: true,
    write: false,
    invite: false,
    remove: false
  }])