class SignUpEmailPasswordFailure {
  final String message;

  const SignUpEmailPasswordFailure([this.message = "An unknown error occurred."]);

  factory SignUpEmailPasswordFailure.code(String code) {
    switch(code) {
      case 'weak-password' :
        return const SignUpEmailPasswordFailure('Please enter a strong password!');
      case 'invalid-email' :
        return const SignUpEmailPasswordFailure('Email is invalid or badly formatted!');
      case 'email-already-in-use' :
        return const SignUpEmailPasswordFailure('An account already exits for that email!');
      case 'operation-not-allowed' :
        return const SignUpEmailPasswordFailure('Operation is not allowed, please contact support!');
      case 'user-disabled' :
        return const SignUpEmailPasswordFailure('This user has been disabled, please contact support for help! ');
      default : return SignUpEmailPasswordFailure();
    }
  }
}