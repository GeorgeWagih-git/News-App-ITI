abstract class ThemeEvents {}

class InitTheme extends ThemeEvents {}

class ChangeTheme extends ThemeEvents {
  bool isLight;
  ChangeTheme({required this.isLight});
}
