// enum Endpoints{
//   // get(""),

//  String url;
//  const Endpoints();
// }
class URL {
  const URL();
  static const baseUrl = "api.dictionaryapi.dev";

  Uri getUri(
      {String? path,
      Map<String, dynamic>? queryParams,
      required String endpoint}) {
    var url = Uri.https(
        baseUrl, (path ?? "/api/v2/entries/en/") + endpoint, queryParams);

    return url;
  }
}
