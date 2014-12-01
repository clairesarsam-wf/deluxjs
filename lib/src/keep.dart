part of deluxjs;

class Keep {
  static List createdStores = [];

  static List createdActions = [];

  static void reset() {
    createdStores.clear();
    createdActions.clear();
  }
}