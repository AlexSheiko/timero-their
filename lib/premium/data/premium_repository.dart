import 'dart:io';

import 'package:error_handling/error_handling.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PremiumRepository {
  PremiumRepository();

  bool hasPremiumInDebugMode = false;

  Future<bool> hasPremium() async {
    if (kDebugMode || (Platform.isAndroid && kReleaseMode)) {
      return hasPremiumInDebugMode;
    }
    final purchaserInfo = await Purchases.getCustomerInfo();
    return purchaserInfo.entitlements.all['premium']?.isActive ?? false;
  }

  Future<void> purchase() async {
    if (kDebugMode || (Platform.isAndroid && kReleaseMode)) {
      hasPremiumInDebugMode = true;
      return;
    }
    try {
      await Purchases.purchaseProduct(
        'premium',
        type: PurchaseType.inapp,
      );
    } on PlatformException catch (e) {
      if (PurchasesErrorHelper.getErrorCode(e) ==
          PurchasesErrorCode.purchaseCancelledError) {
        throw UserCanceledException();
      }
      rethrow;
    }
  }
}
