Geocoder.configure(
  lookup: :google,
  use_https: true,
  api_key: ENV["GEOCORDING_API_KEY"],
  units: :km
)