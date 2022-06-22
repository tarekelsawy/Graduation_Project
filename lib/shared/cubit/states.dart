abstract class CoronaStates {}

class CoronaInitState extends CoronaStates {}

class CoronaOnChangeQuestionPageIndexState extends CoronaStates {}

class CoronaOnChangeSliderValueState extends CoronaStates {}

class CoronaOnPickedImageState extends CoronaStates {}

class CoronaGetUserLoadingState extends CoronaStates {}

class CoronaGetUserSuccessState extends CoronaStates {}

class CoronaGetUserErrorState extends CoronaStates {}

//suffix password Icon in edit profile
class CoronaShowPasswordState extends CoronaStates {}

// image picker in profile editing

class CoronaPickProfileImageState extends CoronaStates {}

// upload profile image

class CoronaUploadProfileImageSuccessState extends CoronaStates {}

class CoronaUploadProfileImageErrorState extends CoronaStates {
  final String message;
  CoronaUploadProfileImageErrorState(this.message);
}

// update profile

class CoronaUpdateProfileErrorState extends CoronaStates {
  final String message;
  CoronaUpdateProfileErrorState(this.message);
}

class CoronaUpdateProfileSuccessState extends CoronaStates {}

//upload image url to firestore
class CoronaUploadProfileURLToFireStoreLoadingState extends CoronaStates {}

class CoronaUploadProfileURLToFireStoreErrorState extends CoronaStates {
  final String message;
  CoronaUploadProfileURLToFireStoreErrorState(this.message);
}

class CoronaUploadProfileURLToFireStoreSuccessState extends CoronaStates {}

// sign out states

class CoronaSignOutLoadingState extends CoronaStates {}

class CoronaSignOutSuccessState extends CoronaStates {}

class CoronaSignOutErrorState extends CoronaStates {
  final String message;
  CoronaSignOutErrorState(this.message);
}

// dark mode
class CoronaChangeAppModeState extends CoronaStates {}

// change value of drop Down Button

class CoronaChangeDropDownButtonValueState extends CoronaStates {}
