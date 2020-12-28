class HelperFunctions {
  static String getConvoID(String uid, String pid) {
    return uid.hashCode <= pid.hashCode ? uid + '_' + pid : pid + '_' + uid;
  }
}
