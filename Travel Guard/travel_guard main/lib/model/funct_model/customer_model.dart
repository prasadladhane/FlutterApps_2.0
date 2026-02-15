// Customer Model Class

class CustomerModel {
  final String firstName;
  final String lastName;
  final int mobNo;
  final String emailId;
  final int password;
  final String location;

  CustomerModel(
      {required this.firstName,
      required this.emailId,
      required this.lastName,
      required this.mobNo,
      required this.password,
      required this.location});

      Map<String,dynamic> customerModelMap(){
        return {
          'firstName':firstName,
          'lastName':lastName,
          'mobNo':mobNo,
          'emailId':emailId,
          'password':password,
          'location':location

        };
      }
}