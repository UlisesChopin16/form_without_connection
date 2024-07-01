class Validations {
  static bool isEmailValid(String email) {
    if(!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)){
      return false;
    } 
    return true;
  }

  static bool isPasswordValid(String password) {
    if (password.length < 6) {
      return false;
    }
    if (password.trim().isEmpty) {
      return false;
    }
    return true;
  }

  static bool isUserNameValid(String userName) {
    if (userName.trim().isEmpty) {
      return false;
    }
    return true;
  }

  static bool isMobileNumberValid(String mobileNumber) {
    if (mobileNumber.trim().isEmpty) {
      return false;
    }
    if (mobileNumber.length < 10 || mobileNumber.length > 10) {
      return false;
    }
    return true;
  }
}