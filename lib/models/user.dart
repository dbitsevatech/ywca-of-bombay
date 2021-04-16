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

  save() {
    print('saving user using a web service');
  }
}
