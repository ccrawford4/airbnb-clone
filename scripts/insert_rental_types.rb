# { name: 'House', image_url: '' },
rental_types = [
  { name: 'Apartment', image_url: '' },
  { name: 'Barn', image_url: '' },
  { name: 'Bed & breakfast', image_url: '' },
  { name: 'Boat', image_url: '' },
  { name: 'Cabin', image_url: '' },
  { name: 'Camper/RV', image_url: '' },
  { name: 'Casa particular', image_url: '' },
  { name: 'Castle', image_url: '' }
]

rental_types.each do |rental_type|
  RentalType.create!(rental_type)
end
