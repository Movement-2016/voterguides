# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if !Location.any?
  locations = []
  CSV.foreach(Rails.root.join('test/support/geo/zips.csv')) do |row|
    locations << { zipcode: row[0].rjust(5, '0'), city: row[1], county: row[2], state: row[3] }
    if locations.length % 5000 == 0
      Location.transaction do
        Location.create locations
        locations = []
      end
    end
  end
  Location.create locations
end
