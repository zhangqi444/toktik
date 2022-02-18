// TODO: migrate all arguments to parameters when invoke Get.toNamedxxx()
enum NavigationArgument {
  // General
  ID,

  // Auth
  ACCOUNT,
  EMAIL,
  USERNAME,
  ERROR_MESSAGE,
  PASSWORD,
  PHONE_NUMBER,
  AUTH_STATUS,
  DESTINATION,
  IS_RESET_PASSWORD,

  // User
  IS_LOGIN_USER,

  // Webview
  URL,

  // Feed Publish
  PODCAST_URL
}

extension ParseToString on NavigationArgument {
  String toShortString() {
    return this.toString().split('.').last;
  }
}