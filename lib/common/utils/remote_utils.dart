dynamic getData(dynamic result) => result['data'];
int getCode(dynamic result) => result['code'];

List<dynamic> getDataList(dynamic result) => result['data'];

dynamic getErrorResult(dynamic result) => result['error'];

String getFormattedUrl(String url, Map<String, String> variables) {
  return url.replaceAllMapped(RegExp(r'{{\w+}}'), (match) {
    final key = match.group(0).replaceAll(RegExp(r'[{}]'), '');
    return variables[key];
  });
}
