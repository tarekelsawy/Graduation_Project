abstract class LoginAndRegisterStates {}

class LoginAndRegisterInitialState extends LoginAndRegisterStates {}

class LoginAndRegisterToggleScreenState extends LoginAndRegisterStates {}

// login states
class LoginChangeObsecureState extends LoginAndRegisterStates {}

class LoginLoadingState extends LoginAndRegisterStates {}

class LoginSuccessState extends LoginAndRegisterStates {
  final String uId;

  LoginSuccessState(this.uId);
}

class LoginErrorState extends LoginAndRegisterStates {
  String errorMessage;
  LoginErrorState(this.errorMessage);
}

// register state
class RegisterChangeObsecureState extends LoginAndRegisterStates {}

class RegisterChangeObsecure extends LoginAndRegisterStates {}

class RegisterLoadingState extends LoginAndRegisterStates {}

class RegisterSuccessState extends LoginAndRegisterStates {}

class RegisterErrorState extends LoginAndRegisterStates {
  String errorMessage;
  RegisterErrorState(this.errorMessage);
}

//create user states
class RegisterSuccessCreateUserState extends LoginAndRegisterStates {
  final String uId;
  RegisterSuccessCreateUserState(this.uId);
}

class RegisterErrorCreateUserState extends LoginAndRegisterStates {
  String errorMessage;
  RegisterErrorCreateUserState(this.errorMessage);
}
