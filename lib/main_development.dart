import 'dart:io';

import 'package:comparador_de_precos/app/app.dart';
import 'package:comparador_de_precos/app/config/dependencies.dart';
import 'package:comparador_de_precos/bootstrap.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Intl.defaultLocale = 'pt_AO';
  timeago.setLocaleMessages('pt_BR_short', timeago.PtBrShortMessages());

  await Supabase.initialize(
    url: 'https://yrouhkfyreqgsugljnbt.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJl'
        'ZiI6Inlyb3Voa2Z5cmVxZ3N1Z2xqbmJ0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDcxNz'
        'UxOTcsImV4cCI6MjA2Mjc1MTE5N30.PzqUT8blpH0Dk13oMKjZop9W08-WmQUI8GX'
        'ZWnKJvRw',
  );

  await setupDependencies();

  // if is running on android, device preview is not available
  if (Platform.isAndroid) {
    await bootstrap(
      () => const App(),
    );
    return;
  }

  await bootstrap(
    () => DevicePreview(
      builder: (context) => const App(),
    ),
  );
}
