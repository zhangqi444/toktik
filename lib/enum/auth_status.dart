enum AuthStatus {
  USERNAME_EXISTS,
  INVALID_PASSWORD,
  INVALID_PARAMETER,
  CONFIRM_SIGN_UP_STEP,
  INVALID_SIGN_IN_STATE,
  RESENT_SIGN_UP_CODE_SUCCESSFUL,
  ALIAS_EXISTS,
  SIGN_UP_DONE,
  SIGN_IN_DONE,
  USER_NOT_FOUND,
  NOT_AUTHORIZED,
  RESET_PASSWORD_DONE,
  UNKNOWN
}

extension ParseToString on AuthStatus {
  String toShortString() {
    return this.toString().split('.').last;
  }
}