import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:timero/app/view/app.dart';
import 'package:timero/current_user/data/current_user.dart';
import 'package:timero/current_user/data/current_user_repository.dart';
import 'package:timero/firebase_options.dart';
import 'package:timero/home/data/goals_repository.dart';
import 'package:timero/premium/data/premium_repository.dart';
import 'package:timero/user_details/model/user_details_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initBilling();
  await Hive.initFlutter();
  Hive.registerAdapter(CurrentUserAdapter());
  final currentUserBox = await Hive.openBox<CurrentUser>('current_user');
  final currentUserRepository = CurrentUserRepository(currentUserBox);
  await Firebase.initializeApp(
    options: kIsWeb ? DefaultFirebaseOptions.currentPlatform : null,
  );
  final firebaseFirestore = FirebaseFirestore.instance;
  final userDetailsRepository = UserDetailsRepository(
    currentUserRepository,
    firebaseFirestore,
  );
  final goalsRepository = GoalsRepository(
    firebaseFirestore,
    currentUserRepository,
    userDetailsRepository,
  );
  final premiumRepository = PremiumRepository();

  runApp(DevicePreview(
      enabled: kDebugMode || kReleaseMode,
      builder: (context) {
        return App(
          goalsRepository: goalsRepository,
          currentUserRepository: currentUserRepository,
          premiumRepository: premiumRepository,
        );
      }));
}

Future<void> _initBilling() async {
  await Purchases.setDebugLogsEnabled(false);
  final apiKey = Platform.isIOS
      ? 'appl_dfiYNtbKjqbhlPMEjnIGJuRmxKR'
      : 'goog_ctzjLSgsAaYQbjIpfAVdkLKVooa';
  await Purchases.setup(apiKey);
}
