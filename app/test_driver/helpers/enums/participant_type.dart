import '../helper.dart';

enum ParticipantTypeTestHelper {
  newbie(
    'Newbie',
    educationDialogScreenshotName: Screenshots.homeRegisteredAsNewbieConfirmDialog,
    screenshotName: Screenshots.homeRegisteredAsNewbie,
  ),
  bootstrapper(
    'Bootstrapper',
    educationDialogScreenshotName: Screenshots.homeRegisteredAsBootstrapperConfirmDialog,
    screenshotName: Screenshots.homeRegisteredAsBootstrapper,
  ),
  reputable(
    'Reputable',
    educationDialogScreenshotName: Screenshots.homeRegisteredAsReputableConfirmDialog,
    screenshotName: Screenshots.homeRegisteredAsReputable,
  ),
  endorsee(
    'Endorsee',
    educationDialogScreenshotName: Screenshots.homeRegisteredAsEndorseeConfirmDialog,
    screenshotName: Screenshots.homeRegisteredAsEndorsee,
  );

  const ParticipantTypeTestHelper(
    this.type, {
    required this.educationDialogScreenshotName,
    required this.screenshotName,
  });

  final String type;
  final String educationDialogScreenshotName;
  final String screenshotName;
}
