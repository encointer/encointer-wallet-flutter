// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bazaar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IpfsBusiness _$IpfsBusinessFromJson(Map<String, dynamic> json) {
  return IpfsBusiness(
    json['name'] as String,
    json['description'] as String,
  );
}

Map<String, dynamic> _$IpfsBusinessToJson(IpfsBusiness instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
    };

IpfsOffering _$IpfsOfferingFromJson(Map<String, dynamic> json) {
  return IpfsOffering(
    json['name'] as String,
    json['price'] as int,
    json['cid'] as String,
    json['imageCid'] as String,
  );
}

Map<String, dynamic> _$IpfsOfferingToJson(IpfsOffering instance) =>
    <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'cid': instance.cid,
      'imageCid': instance.imageCid,
    };

BusinessData _$BusinessDataFromJson(Map<String, dynamic> json) {
  return BusinessData(
    json['url'] as String,
    json['lastOid'] as int,
  );
}

Map<String, dynamic> _$BusinessDataToJson(BusinessData instance) =>
    <String, dynamic>{
      'url': instance.url,
      'lastOid': instance.lastOid,
    };

OfferingData _$OfferingDataFromJson(Map<String, dynamic> json) {
  return OfferingData(
    json['url'] as String,
  );
}

Map<String, dynamic> _$OfferingDataToJson(OfferingData instance) =>
    <String, dynamic>{
      'url': instance.url,
    };

AccountBusinessTuple _$AccountBusinessTupleFromJson(Map<String, dynamic> json) {
  return AccountBusinessTuple(
    json['controller'] as String,
    json['businessData'] == null
        ? null
        : BusinessData.fromJson(json['businessData'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AccountBusinessTupleToJson(
        AccountBusinessTuple instance) =>
    <String, dynamic>{
      'controller': instance.controller,
      'businessData': instance.businessData,
    };

BusinessIdentifier _$BusinessIdentifierFromJson(Map<String, dynamic> json) {
  return BusinessIdentifier(
    json['cid'] as String,
    json['controller'] as String,
  );
}

Map<String, dynamic> _$BusinessIdentifierToJson(BusinessIdentifier instance) =>
    <String, dynamic>{
      'cid': instance.cid,
      'controller': instance.controller,
    };
