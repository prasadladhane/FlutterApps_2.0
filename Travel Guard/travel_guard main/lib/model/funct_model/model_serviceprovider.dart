// Service Provider Model Class

class ServiceProviderModel {
  final String firstName;
  final String lastName;
  final int mobNo;
  final String emailId;
  final int password;
  final String location;
  final String serviceType;

  ServiceProviderModel(
      {required this.serviceType,
      required this.firstName,
      required this.emailId,
      required this.lastName,
      required this.mobNo,
      required this.password,
      required this.location});

       Map<String,dynamic> serviceProviderModelMap(){
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