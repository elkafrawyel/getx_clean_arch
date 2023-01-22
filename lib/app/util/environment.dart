class Environment {
  static const AppMode appMode = AppMode.testing;

  static url() {
    switch (appMode) {
      case AppMode.testing:
      case AppMode.staging:
        return 'https://host-n.com/api/app';
      case AppMode.live:
        return 'https://host-n.com/api/app';
    }
  }
}

enum AppMode {
  testing,
  staging,
  live,
}
