// ignore_for_file: avoid_classes_with_only_static_members, constant_identifier_names

abstract final class Endpoints {
  static const BASE_URL_AUTH = "https://base-url.com/api/v1/";

  static String getTaskDetail({required String id}) => "${BASE_URL_AUTH}data";
  static const GET_FILE_CATEGORIES = "${BASE_URL_AUTH}data";
}
