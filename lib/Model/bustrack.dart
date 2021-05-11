class bustrack {
  String Phone, Address;
  var latitude, longitude;
  bustrack({this.Address, this.Phone, this.latitude, this.longitude});

  factory bustrack.fromDocument(doc) {
    return bustrack(
        Address: doc['Address'],
        Phone: doc['Phone'],
        latitude: doc['latitude'],
        longitude: doc['longitude']);
  }
}
