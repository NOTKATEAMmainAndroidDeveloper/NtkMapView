///Class to apply a filter to map
///
///
/// **[blur]** create a blur effect (px) <= 20
///
/// **[invert]** invert a color (%) <= 1
///
/// **[grayscale]** make map more grey (%) <= 1
///
/// **[bright]** light effect of map (%) <= 2
///
/// **[contrast]** change map contrast (%) <= 2
///
/// **[hue]** change all map color (deg) <= 359
///
/// **[opacity]** opacity of map (%) <= 1
///
/// **[saturate]** saturation of map (%) <= 10
///
/// **[sepia]** make a burnout effect <= 1
///
/// *remember that 1 = 100%, 0.56 = 56% and etc.*
class MapFilter {
  MapFilter(
      {this.blur = 0,
      this.invert = 0,
      this.grayscale = 0,
      this.bright = 1,
      this.contrast = 1,
      this.hue = 0,
      this.opacity = 1,
      this.saturate = 1,
      this.sepia = 0});

  /// **[blur]** create a blur effect (px) <= 20
  int blur = 0;

  /// **[invert]** invert a color (%) <= 1
  double invert = 0;

  /// **[grayscale]** make map more grey (%) <= 1
  double grayscale = 0;

  /// **[bright]** light effect of map (%) <= 2
  double bright = 1;

  /// **[contrast]** change map contrast (%) <= 2
  double contrast = 1;

  /// **[hue]** change all map color (deg) <= 359
  int hue = 0;

  /// **[opacity]** opacity of map (%) <= 1
  double opacity = 1;

  /// **[saturate]** saturation of map (%) <= 10
  double saturate = 1;

  /// **[sepia]** make a burnout effect <= 1
  double sepia = 0;

  ///**[_makeDataValid]** if value dont valid, set it to minimum or maximum
  _makeDataValid() {
    if (blur < 0) blur = 0;
    if (invert < 0) invert = 0;
    if (grayscale < 0) grayscale = 0;
    if (bright < 0) bright = 0;
    if (contrast < 0) contrast = 0;
    if (hue < 0) hue = 0;
    if (opacity < 0) opacity = 0;
    if (saturate < 0) saturate = 0;
    if (sepia < 0) sepia = 0;

    if (blur > 20) blur = 20;
    if (invert > 1) invert = 1;
    if (grayscale > 1) grayscale = 1;
    if (bright > 2) bright = 2;
    if (contrast > 2) contrast = 2;
    if (hue > 359) hue = 359;
    if (opacity > 100) opacity = 100;
    if (saturate > 10) saturate = 10;
    if (sepia > 1) sepia = 1;
  }

  /// **[toParameterString]** make String to apply this as filter
  List<String> toParameterString() {
    _makeDataValid();

    return [
      "${blur}px",
      "${invert * 100}%",
      "${grayscale * 100}%",
      "${bright * 100}%",
      "${contrast * 100}%",
      "${hue}deg",
      "${opacity * 100}%",
      "${saturate * 100}%",
      "${sepia * 100}%",
    ];
  }
}
