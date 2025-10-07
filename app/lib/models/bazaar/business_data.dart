import 'dart:convert';

class BusinessData {
  BusinessData(this.url, this.lastOid);

  factory BusinessData.fromJson(Map<String, dynamic> json) {
    final urlValue = json['url'];
    String urlString;

    if (urlValue is List) {
      // convert list of bytes to string
      urlString = utf8.decode(List<int>.from(urlValue));
    } else if (urlValue is String) {
      urlString = urlValue;
    } else {
      throw JsonUnsupportedObjectError(json, cause: 'Invalid Url value; needs to be a utf8 byte list or String');
    }

    return BusinessData(
      urlString,
      json['lastOid'] as int,
    );
  }

  final String url;
  final int lastOid;

  Map<String, dynamic> toJson() => {
        'url': url,
        'lastOid': lastOid,
      };
}
