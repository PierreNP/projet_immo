User.destroy_all
Place.destroy_all
Listing.destroy_all
Amenity.destroy_all
TableJointPlaceAmenity.destroy_all

['users', 'places', 'listings', 'amenities', 'table_joint_place_amenities'].map { |tab| ActiveRecord::Base.connection.reset_pk_sequence!(tab) }

admin_user = User.create(email:"admin@admin.com", password:"123456", first_name:"Stephane", last_name:"Plaza", username:"superplaza", is_admin:true)

tab_place = ["studio", "small_apartment", "big_apartment", "small_house", "big_house"]

30.times do |i|
  user = User.create(email:"email#{i}@yopmail.com", password:"123456", first_name:Faker::Name.first_name, last_name:Faker::Name.last_name, username:Faker::Internet.username, is_admin:false)
  [1,1,1,1,1,2][rand(0..5)].times do
    place = Place.create(place_type:tab_place[rand(0..tab_place.length - 1)], surface:rand(15..200), story:rand(0..6), location:Faker::Address.street_address)
    listing = Listing.create(landlord:user, place:place, title:"Amazing place to sell! #{i}", description:"description of place #{i}", price:place.surface*rand(7..13)*1000)
    if place.story == 6
      last_floor=true
    else
      last_floor = false
    end
    amenity = Amenity.create(has_swimming_pool:[true, false, false][rand(0..2)],has_garden:[true, false, false][rand(0..2)], has_balcony:[true, false, false][rand(0..2)], has_terrace:[true, false, false][rand(0..2)],has_elevator:[true, false, false][rand(0..2)],has_concierge:[true, false, false][rand(0..2)],is_last_floor:last_floor)
    tablejointplaceamenity = TableJointPlaceAmenity.create(place:place, amenity:amenity)
  end
end

