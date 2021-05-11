class userprofile {
  String uid, email, password, phone, classroom, location, name, Photo;
  var changeYear;
  var CheckFees, Fees, FeesPaid, checkFees;

  userprofile(
      {this.uid,
      this.email,
      this.password,
      this.phone,
      this.classroom,
      this.location,
      this.name,
      this.Photo,
      this.changeYear,
      this.CheckFees,
      this.Fees,
      this.FeesPaid,
      this.checkFees});

  factory userprofile.fromDocument(doc) {
    return userprofile(
        uid: doc['uid'],
        email: doc['email'],
        password: doc['password'],
        phone: doc['phone'],
        classroom: doc['classroom'],
        location: doc['location'],
        name: doc['name'],
        Photo: doc['Photo'],
        changeYear: doc['changeYear'],
        CheckFees: doc['CheckFees'],
        Fees: doc['Fees'],
        FeesPaid: doc['FeesPaid'],
        checkFees: doc['checkFees']);
  }
}
