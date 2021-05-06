class LocationData {
  String Address;
  var latitude, longitude;

  LocationData({
    this.Address,
    this.latitude,
    this.longitude,
  });

  factory LocationData.fromDocument(doc) {
    return LocationData(
      Address: doc['Address'],
      latitude: doc['latitude'],
      longitude: doc['longitude'],
    );
  }
}
