// ignore_for_file: avoid_classes_with_only_static_members

abstract final class Endpoints {
  static const baseUrlAuth = "https://base-url.com/api/v1/";

  static String getTaskDetail({required String id}) => "${baseUrlAuth}data";
  static const getFileCategories = "${baseUrlAuth}data";
}
