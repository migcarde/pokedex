const iconsBasePath = 'assets/icons';

enum LocalSvgIcons {
  hp('$iconsBasePath/heart.svg'),
  attack('$iconsBasePath/sword.svg'),
  defense('$iconsBasePath/shield.svg'),
  specialAttack('$iconsBasePath/fire.svg'),
  specialDefense('$iconsBasePath/special_defense.svg'),
  speed('$iconsBasePath/speed.svg');

  final String path;

  const LocalSvgIcons(this.path);
}
