import 'package:flutter/material.dart';
import 'package:form_without_connection/app/app_preferences.dart';
import 'package:form_without_connection/app/dep_inject.dart';
import 'package:form_without_connection/domain/use_cases/register_use_case.dart';
import 'package:form_without_connection/presentation/common/state_render_impl.dart';
import 'package:form_without_connection/presentation/common/state_renderer.dart';
import 'package:form_without_connection/presentation/validations/validations.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'register_view_model.freezed.dart';
part 'register_view_model.g.dart';

@freezed
class RegisterModel with _$RegisterModel {
  const RegisterModel._();
  
  const factory RegisterModel({
    @Default('') String countryMobileCode,
    @Default('') String userName,
    @Default('') String email,
    @Default('') String password,
    @Default('') String mobileNumber,
    @Default('') String profilePicture,
    @Default(true) bool isUserNameValid,
    @Default(true) bool isEmailValid,
    @Default(true) bool isPasswordValid,
    @Default(true) bool isMobileNumberValid,
    @Default(false) bool isAllInputsValid,
    @Default(null) FlowState? flowState,
  }) = _RegisterModel;

  RegisterUseCaseInput toRequest() {
    return RegisterUseCaseInput(
      email: email,
      password: password,
      countryMobileCode: countryMobileCode.isEmpty ? '+52' : countryMobileCode.trim(),
      userName: userName,
      mobileNumber: mobileNumber,
      profilePicture: profilePicture,
    );
  }
}

@riverpod
class RegisterViewModel extends _$RegisterViewModel implements RegisterViewModelInputs {
  final RegisterUseCase _registerUseCase = instance<RegisterUseCase>();
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final ImagePicker _picker = instance<ImagePicker>();

  @override
  RegisterModel build() {
    return const RegisterModel();
  }

  @override
  void onCountryMobileCodeChanged(String countryMobileCode) {
    state = state.copyWith(
      countryMobileCode: countryMobileCode.trim(),
    );
    _validate();
  }

  @override
  void onUserNameChanged(String userName) {
    state = state.copyWith(
      userName: userName.trim(),
      isUserNameValid: Validations.isUserNameValid(userName),
    );
    _validate();
  }

  @override
  void onEmailChanged(String email) {
    state = state.copyWith(
      email: email.trim(),
      isEmailValid: Validations.isEmailValid(email),
    );
    _validate();
  }

  @override
  void onPasswordChanged(String password) {
    state = state.copyWith(
      password: password.trim(),
      isPasswordValid: Validations.isPasswordValid(password),
    );
    _validate();
  }

  @override
  void onMobileNumberChanged(String mobileNumber) {
    state = state.copyWith(
      mobileNumber: mobileNumber.trim(),
      isMobileNumberValid: Validations.isMobileNumberValid(mobileNumber),
    );
    _validate();
  }

  @override
  void onChooseProfilePicture(String profilePicture) {
    state = state.copyWith(
      profilePicture: profilePicture,
    );
  }

  @override
  void onRegister({required VoidCallback onDone}) async {
    state = state.copyWith(
      flowState: LoadingState(
        stateRendererType: StateRendererType.POPUP_LOADING_STATE,
      ),
    );
    final response = await _registerUseCase.execute(state.toRequest());

    response.fold(
      (failure) {
        state = state.copyWith(
          flowState: ErrorState(
            stateRendererType: StateRendererType.POPUP_ERROR_STATE,
            message: failure.message,
          ),
        );
      },
      (registerResponseModel) {
        state = state.copyWith(
          flowState: SuccessState(
            stateRendererType: StateRendererType.POPUP_SUCCESS,
            message: registerResponseModel.message,
          ),
        );
        _appPreferences.setIsUserLoggedIn();
        onDone();
      },
    );
  }

  @override
  void retryAction() {
    print('retryAction');
    state = state.copyWith(
      flowState: ContentState(isPop: true),
    );
  }

  bool validateAllInputs() {
    return Validations.isUserNameValid(state.userName) &&
        Validations.isEmailValid(state.email) &&
        Validations.isPasswordValid(state.password) &&
        Validations.isMobileNumberValid(state.mobileNumber);
  }

  void _validate() {
    state = state.copyWith(
      isAllInputsValid: validateAllInputs(),
    );
  }

  Future<void> imageFromGallery() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    onChooseProfilePicture(image?.path ?? '');
  }

  Future<void> imageFromCamera() async {
    var image = await _picker.pickImage(source: ImageSource.camera);
    onChooseProfilePicture(image?.path ?? '');
  }
}

abstract class RegisterViewModelInputs {
  void onCountryMobileCodeChanged(String countryMobileCode);
  void onUserNameChanged(String userName);
  void onEmailChanged(String email);
  void onPasswordChanged(String password);
  void onMobileNumberChanged(String mobileNumber);
  void onChooseProfilePicture(String profilePicture);
  void onRegister({required VoidCallback onDone});
  void retryAction();
}
