class User {
  String firstName = '';
  String lastName = '';
  DateTime dateOfBirth = DateTime.now().subtract(Duration(days: 4380));
  String emailId = '';
  String phoneNumber = '';
  String gender = 'Female';
  String profession = '';
  String placeOfWork = '';
  String nearestCenter = 'Chembur';
  String interestInMembership = 'Yes';

  User(
    this.firstName,
    this.lastName,
    this.dateOfBirth,
    this.emailId,
    this.phoneNumber,
    this.gender,
    this.profession,
    this.placeOfWork,
    this.nearestCenter,
    this.interestInMembership,
  );

  // save() {
  //   print('saving user using a web service');
  // }
}
