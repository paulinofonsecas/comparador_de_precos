import 'dart:io';

import 'package:clarity_flutter/clarity_flutter.dart';
import 'package:comparador_de_precos/app/app.dart';
import 'package:comparador_de_precos/app/config/dependencies.dart';
import 'package:comparador_de_precos/bootstrap.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Intl.defaultLocale = 'pt_AO';
  await initializeDateFormatting('pt_AO');
  timeago.setLocaleMessages('pt_BR_short', timeago.PtBrShortMessages());

  await Supabase.initialize(
    url: 'https://yrouhkfyreqgsugljnbt.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inlyb3Voa2Z5cmVxZ3N1Z2xqbmJ0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDcxNzUxOTcsImV4cCI6MjA2Mjc1MTE5N30.PzqUT8blpH0Dk13oMKjZop9W08-WmQUI8GXZWnKJvRw',
  );

  await setupDependencies();

  // if is running on android, device preview is not available
  if (!kIsWeb && Platform.isAndroid) {
    await bootstrap(
      () => const WrapperApp(),
    );
    return;
  }

  await bootstrap(
    () => DevicePreview(
      builder: (context) => const WrapperApp(),
    ),
  );
}

class WrapperApp extends StatelessWidget {
  const WrapperApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Clarity Configure
    final config = ClarityConfig(
      projectId: 's9uvmzz5ay',
      logLevel: LogLevel.Verbose,
    );

    return ClarityWidget(
      app: const App(),
      clarityConfig: config,
    );
  }
}
