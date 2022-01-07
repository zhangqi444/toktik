enum AuthStatus {
  USERNAME_EXISTS,
  INVALID_PASSWORD,
  CONFIRM_SIGN_UP_STEP,
  INVALID_SIGN_IN_STATE,
  RESENT_SIGN_UP_CODE_SUCCESSFUL,
  ALIAS_EXISTS,
  SIGN_UP_DONE,
  SIGN_IN_DONE,
  USER_NOT_FOUND,
  NOT_AUTHORIZED,
  UNKNOWN
}

extension ParseToString on AuthStatus {
  String toShortString() {
    return this.toString().split('.').last;
  }
}