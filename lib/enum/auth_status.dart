enum AuthStatus {
  USERNAME_EXISTS,
  INVALID_PASSWORD,
  CONFIRM_SIGN_UP_STEP,
  INVALID_SIGN_IN_STATE,
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