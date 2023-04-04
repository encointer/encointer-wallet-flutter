import 'screenshots.dart';

enum ParticipantType {
  newbie(
    'Newbie',
    educationDialogScreenshot: Screenshots.homeRegisteredAsNewbieConfirmDialog,
    registeredAsType: Screenshots.homeRegisteredAsNewbie,
  ),
  bootstrapper(
    'Bootstrapper',
    educationDialogScreenshot: Screenshots.homeRegisteredAsBootstrapperConfirmDialog,
    registeredAsType: Screenshots.homeRegisteredAsBootstrapper,
  ),
  reputable(
    'Reputable',
    educationDialogScreenshot: Screenshots.homeRegisteredAsReputableConfirmDialog,
    registeredAsType: Screenshots.homeRegisteredAsReputable,
  ),
  endorsee(
    'Endorsee',
    educationDialogScreenshot: Screenshots.homeRegisteredAsEndorseeConfirmDialog,
    registeredAsType: Screenshots.homeRegisteredAsEndorsee,
  );

  const ParticipantType(
    this.type, {
    required this.educationDialogScreenshot,
    required this.registeredAsType,
  });

  final String type;
  final String educationDialogScreenshot;
  final String registeredAsType;
}
