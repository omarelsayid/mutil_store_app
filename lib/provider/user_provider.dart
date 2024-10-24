import '../models/user.dart';
import 'package:riverpod/riverpod.dart';

class UserProvider extends StateNotifier<User?> {
// constructor intializing with default Uer object

  // purpose Manage the state of the use object allowing update
  UserProvider()
      : super(
          User(
            id: '',
            password: '',
            fullName: '',
            email: '',
            state: '',
            city: '',
            locality: '',
            token: '',
          ),
        );

  // Getter method to extract value from an object

  User? get user => state;

  // method to set user state from json

  // purpose :updates the user state base on json String  representation of user object

  void setUser(String userJson) {
    state = User.fromJson(userJson);
  }

// Method to clear user state
  void singOut() {
    state = null;
  }

//Method to Recreate the user state
  void recreateUserState({
    required String state,
    required String city,
    required String locality,
  }) {
    if (this.state != null) {
      this.state = User(
        id: this.state!.id, //Preserve the existing user id
        fullName: this.state!.fullName, // preserve the existing user fullname
        email: this.state!.email, // preserve the existing user email
        state: state,
        city: city,
        locality: locality,
        password: this.state!.password, // preserve the existing user password
        token: this.state!.token, // preserve the existing user token
      );
    }
  }
}

// make the accessible within the application

final userProvider =
    StateNotifierProvider<UserProvider, User?>((ref) => UserProvider());
