dynamic getData(dynamic result) => result['results'];

int getCode(dynamic result) => result['code'];

dynamic getDataList(dynamic result) => result['total_results'];

dynamic getErrorResult(dynamic result) => result['error'];

String getFormattedUrl(String url, Map<String, String> variables) {
  return url.replaceAllMapped(RegExp(r'{{\w+}}'), (match) {
    final key = match.group(0).replaceAll(RegExp(r'[{}]'), '');
    return variables[key];
  });
}
