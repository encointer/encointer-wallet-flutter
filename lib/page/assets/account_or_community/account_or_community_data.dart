import 'package:flutter/material.dart';

class AccountOrCommunityData {
  final Widget? avatar; // later Image
  final String? name;
  final bool isSelected;

  AccountOrCommunityData({this.avatar, this.name, this.isSelected = false});
}
