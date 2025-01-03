rental_types = [
  { name: 'House', image_url: 'https://airbnb-clone1.s3.us-west-1.amazonaws.com/protected-assets/house.svg' },
  { name: 'Apartment', image_url: 'https://airbnb-clone1.s3.us-west-1.amazonaws.com/protected-assets/apartment.svg' },
  { name: 'Barn', image_url: 'https://airbnb-clone1.s3.us-west-1.amazonaws.com/protected-assets/barn.svg' },
  { name: 'Bed & breakfast', image_url: 'https://airbnb-clone1.s3.us-west-1.amazonaws.com/protected-assets/bed%26breakfast.svg' },
  { name: 'Boat', image_url: 'https://airbnb-clone1.s3.us-west-1.amazonaws.com/protected-assets/boat.svg' },
  { name: 'Cabin', image_url: 'https://airbnb-clone1.s3.us-west-1.amazonaws.com/protected-assets/cabin.svg' },
  { name: 'Camper/RV', image_url: 'https://airbnb-clone1.s3.us-west-1.amazonaws.com/protected-assets/camper%3Arv.svg' },
  { name: 'Casa particular', image_url: 'https://airbnb-clone1.s3.us-west-1.amazonaws.com/protected-assets/casa-particular.svg' },
  { name: 'Castle', image_url: 'https://airbnb-clone1.s3.us-west-1.amazonaws.com/protected-assets/castle.svg' }
]

rental_types.each do |rental_type|
  RentalType.create!(rental_type)
end
