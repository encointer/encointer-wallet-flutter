import 'package:flutter/material.dart';

class AccountOrCommunityData {
  AccountOrCommunityData({this.avatar, this.name, this.isSelected = false});

  final Widget? avatar; // later Image
  final String? name;
  final bool isSelected;
}
