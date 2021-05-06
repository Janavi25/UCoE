class userprofile {
  String Email, Name, aboutus, uid, Photo, DOB, phone;
  var Date;

  userprofile(
      {this.Email,
      this.Name,
      this.aboutus,
      this.uid,
      this.Photo,
      this.phone,
      this.DOB,
      this.Date});

  factory userprofile.fromDocument(doc) {
    return userprofile(
        Email: doc['Email'],
        Name: doc['Name'],
        aboutus: doc['aboutus'],
        uid: doc['uid'],
        Photo: doc['Photo'],
        DOB: doc['DOB'],
        phone: doc['phone'],
        Date: doc['Date']);
  }
}
