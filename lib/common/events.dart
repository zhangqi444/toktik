// ignore_for_file: non_constant_identifier_names

enum EventType {
  HOME_TAB_RECOMMEND_PAGE_VIEW_VIDEO,
  HOME_TAB_RECOMMEND_PAGE_LOADED,
  HOME_TAB_RECOMMEND_PAGE_LIKE_VIDEO,
}

extension ParseToString on EventType {
  String toShortString() {
    return this.toString().split('.').last;
  }
}

class Events {
  static final String VALUE = 'VALUE';
  static final String TIME = 'TIME';
  static final String DWELL = 'DWELL';
  static final String ID = 'ID';
}

class EventValues {
  static final String NO_OP = 'NO_OP';
}