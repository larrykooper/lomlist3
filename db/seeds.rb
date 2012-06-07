# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
ACTIVITY_TYPES = ["BUDG", "FO", "JOBS", "LA", "LBETH", "MAINT", "NFS"]

ACTIVITY_TYPES.each do |act_type|
  ActType.create(name: act_type)  
end
