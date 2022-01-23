enum AuthNavigationArgument {
  ACCOUNT,
  EMAIL,
  USERNAME,
  ERROR_MESSAGE,
  PASSWORD,
  PHONE_NUMBER,
  AUTH_STATUS,
  DESTINATION,
  IS_RESET_PASSWORD
}

extension ParseToString on AuthNavigationArgument {
  String toShortString() {
    return this.toString().split('.').last;
  }
}