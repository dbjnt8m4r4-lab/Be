import 'package:flutter/widgets.dart';

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static const Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'appTitle': 'To Be',
      'tasks': 'Tasks',
      'loading': 'Loading...',
      'noItems': 'No items',
      'settings': 'Settings',
      'account': 'Account',
      'appearance': 'Appearance',
      'language': 'Language',
      'theme': 'Theme',
      'save': 'Save',
      'save_success': 'Saved',
      'enable_analytics': 'Enable Analytics (progress tracking)',
      'enable_notifications': 'Enable Notifications',
      'permissions_title': 'Permissions',
      'request_location': 'Request Location',
      'request_phone': 'Request Phone',
      'our_goal': 'Our goal is make you a GOAT (Greatest Of All Time)',
    },
    'pt': {
      'appTitle': 'To Be',
      'tasks': 'Tarefas',
      'loading': 'Carregando...',
      'noItems': 'Sem itens',
      'settings': 'Configurações',
      'account': 'Conta',
      'appearance': 'Aparência',
      'language': 'Idioma',
      'theme': 'Tema',
      'save': 'Salvar',
      'save_success': 'Salvo',
      'enable_analytics': 'Ativar análises (rastreamento de progresso)',
      'enable_notifications': 'Ativar notificações',
      'permissions_title': 'Permissões',
      'request_location': 'Solicitar Localização',
      'request_phone': 'Solicitar Telefone',
      'our_goal': 'Nosso objetivo é torná-lo um GOAT (Greatest Of All Time)',
    },
    'es': {
      'appTitle': 'To Be',
      'tasks': 'Tareas',
      'loading': 'Cargando...',
      'noItems': 'Sin elementos',
      'settings': 'Ajustes',
      'account': 'Cuenta',
      'appearance': 'Apariencia',
      'language': 'Idioma',
      'theme': 'Tema',
      'save': 'Guardar',
      'save_success': 'Guardado',
      'enable_analytics': 'Habilitar analíticas (seguimiento de progreso)',
      'enable_notifications': 'Habilitar notificaciones',
      'permissions_title': 'Permisos',
      'request_location': 'Solicitar ubicación',
      'request_phone': 'Solicitar teléfono',
      'our_goal': 'Nuestra meta es convertirte en un GOAT (Greatest Of All Time)',
    },
  };

  // Keep a list of supported language codes in sync with MaterialApp.supportedLocales
  static const List<String> supportedLanguageCodes = [
    'en','es','pt','fr','de','it','nl','sv','da','no','pl','ru','uk','tr','ar','hi','bn','zh','ja','ko'
  ];

  String translate(String key) {
    final map = _localizedValues[locale.languageCode] ?? _localizedValues['en']!;
    return map[key] ?? _localizedValues['en']![key] ?? key;
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)
        ?? AppLocalizations(const Locale('en'));
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => AppLocalizations.supportedLanguageCodes.contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;
}

const appLocalizationsDelegate = AppLocalizationsDelegate();
