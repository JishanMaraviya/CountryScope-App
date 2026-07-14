import '../constants/app_constants.dart';

String flagUrl(String countryCode) => '${AppConstants.flagBaseUrl}/${countryCode.toLowerCase()}.png';
