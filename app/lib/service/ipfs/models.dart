class IpfsLsResponse {
  IpfsLsResponse({required this.objects});

  factory IpfsLsResponse.fromJson(Map<String, dynamic> json) {
    final objectsRaw = json['Objects'] as List<dynamic>? ?? [];
    final objects = objectsRaw.map((e) => IpfsObject.fromJson(e as Map<String, dynamic>)).toList();
    return IpfsLsResponse(objects: objects);
  }

  final List<IpfsObject> objects;
}

class IpfsObject {
  IpfsObject({required this.links});

  factory IpfsObject.fromJson(Map<String, dynamic> json) {
    final linksRaw = json['Links'] as List<dynamic>? ?? [];
    final links = linksRaw.map((e) => IpfsLink.fromJson(e as Map<String, dynamic>)).toList();
    return IpfsObject(links: links);
  }

  final List<IpfsLink> links;
}

/// Model for an IPFS ls result.
class IpfsLink {
  IpfsLink({
    required this.name,
    required this.hash,
    required this.size,
    required this.type,
  });

  factory IpfsLink.fromJson(Map<String, dynamic> json) {
    return IpfsLink(
      name: json['Name'] as String? ?? '',
      hash: json['Hash'] as String? ?? '',
      size: json['Size'] is int ? json['Size'] as int : int.tryParse('${json['Size']}') ?? 0,
      type: (json['Type'] == 1) ? 'Dir' : 'File',
    );
  }

  final String name;
  final String hash;
  final int size;
  final String type;
}
