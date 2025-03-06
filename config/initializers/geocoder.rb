Geocoder.configure(
  lookup: :google,
  api_key: ENV["GEOCODING_API_KEY"],
  use_https: true,
  units: :km
)