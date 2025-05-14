import 'package:comparador_de_precos/app/app.dart';
import 'package:comparador_de_precos/app/config/dependencies.dart';
import 'package:comparador_de_precos/bootstrap.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupDependencies();

  await Supabase.initialize(
    url: 'https://yrouhkfyreqgsugljnbt.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inlyb3Voa2Z5cmVxZ3N1Z2xqbmJ0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDcxNzUxOTcsImV4cCI6MjA2Mjc1MTE5N30.PzqUT8blpH0Dk13oMKjZop9W08-WmQUI8GXZWnKJvRw',
  );

  await bootstrap(() => const App());
}
