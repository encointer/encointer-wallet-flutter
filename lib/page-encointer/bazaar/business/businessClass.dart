import 'package:encointer_wallet/service/ipfsApi/httpApi.dart';
import 'dart:convert';

class Business {
  final String name;
  final String description;
  final String imageHash;

  Business({this.name, this.description, this.imageHash});

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      name: json['name'],
      description: json['description'],
      imageHash: json['imageHash'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'imageHash': imageHash,
      };

  Future<Business> getBusinessData(businessID) async {
    final ipfsObject = await Ipfs().getJson(businessID);
    if (ipfsObject != 0) {
      return Business.fromJson(jsonDecode(ipfsObject)); //store response as string
    } else {
      // TODO: What to do in case of non-existent URL? (i.e. node not running?)
      // in case of invalid IPFS URL
      return Business();
    }
  }
}
