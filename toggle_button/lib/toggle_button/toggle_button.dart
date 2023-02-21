import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'dart:math' as math;

/// A single toggle button.
///
/// The [value] must be provided to change the state of the toggle button.
/// Here is an implementation that allows the toggle button to be selected&unselected on tap.
/// ```dart
/// ToggleButton(
///   value: _isSelected,
///   onPressed: () {
///     setState(() {
///       _isSelected = !_isSelected;
///     });
///   },
///   child: Text('toggle'),
/// ),
/// ```
class ToggleButton extends StatelessWidget {
  const ToggleButton({
    super.key,
    required this.child,
    required this.value,
    this.onPressed,
    this.color,
    this.selectedColor,
    this.disabledColor,
    this.fillColor,
    this.selectedFillColor,
    this.disabledFillColor,
    this.borderColor,
    this.selectedBorderColor,
    this.disabledBorderColor,
    this.focusColor,
    this.highlightColor,
    this.hoverColor,
    this.splashColor,
    this.constraints,
    this.borderRadius,
    this.borderWidth,
    this.renderBorder = true,
    this.textStyle,
    this.mouseCursor,
    this.focusNode,
  });
  static const double _defaultBorderWidth = 1.0;

  /// Child widget of the toggle button.
  final Widget child;

  /// Selection state of the toggle button.
  final bool value;

  /// Callback that is called when tapped.
  final void Function()? onPressed;

  /// The color for descendant [Text] and [Icon] widgets if the button is
  /// enabled and not selected.
  ///
  /// If [onPressed] is not null, this color will be used when [value] is false.
  ///
  /// If this property is null, then ToggleButtonTheme.of(context).color
  /// is used. If [ToggleButtonsThemeData.color] is also null, then
  /// Theme.of(context).colorScheme.onSurface is used.
  final Color? color;

  /// The color for descendant [Text] and [Icon] widgets if the button is
  /// selected.
  ///
  /// If [onPressed] is not null, this color will be used when [value] is true.
  ///
  /// If this property is null, then
  /// ToggleButtonTheme.of(context).selectedColor is used. If
  /// [ToggleButtonsThemeData.selectedColor] is also null, then
  /// Theme.of(context).colorScheme.primary is used.
  final Color? selectedColor;

  /// The color for descendant [Text] and [Icon] widgets if the button is
  /// disabled.
  ///
  /// If [onPressed] is null, this color will be used.
  ///
  /// If this property is null, then
  /// ToggleButtonTheme.of(context).disabledColor is used. If
  /// [ToggleButtonsThemeData.disabledColor] is also null, then
  /// Theme.of(context).colorScheme.onSurface.withOpacity(0.38) is used.
  final Color? disabledColor;

  /// The fill color for enabled and not selected toggle button.
  ///
  /// If this property is null, then
  /// ToggleButtonTheme.of(context).primary.withOpacity(0.12) is used.
  final Color? fillColor;

  /// The fill color for selected toggle button.
  ///
  /// If this property is null, then
  /// ToggleButtonTheme.of(context).fillColor is used. If
  /// [ToggleButtonsThemeData.fillColor] is also null, then
  /// the fill color is transparent.
  final Color? selectedFillColor;

  /// The fill color for disabled toggle buttons.
  ///
  /// If this property is null, then the fill color is transparent.
  final Color? disabledFillColor;

  /// The border color to display when the toggle button is enabled and not
  /// selected.
  ///
  /// If this property is null, then
  /// ToggleButtonTheme.of(context).borderColor is used. If
  /// [ToggleButtonsThemeData.borderColor] is also null, then
  /// Theme.of(context).colorScheme.onSurface is used.
  final Color? borderColor;

  /// The border color to display when the toggle button is selected.
  ///
  /// If this property is null, then
  /// ToggleButtonTheme.of(context).selectedBorderColor is used. If
  /// [ToggleButtonsThemeData.selectedBorderColor] is also null, then
  /// Theme.of(context).colorScheme.primary is used.
  final Color? selectedBorderColor;

  /// The border color to display when the toggle button is disabled.
  ///
  /// If this property is null, then
  /// ToggleButtonTheme.of(context).disabledBorderColor is used. If
  /// [ToggleButtonsThemeData.disabledBorderColor] is also null, then
  /// Theme.of(context).disabledBorderColor is used.
  final Color? disabledBorderColor;

  /// The color to use for filling the button when the button has input focus.
  ///
  /// If this property is null, then
  /// ToggleButtonTheme.of(context).focusColor is used. If
  /// [ToggleButtonsThemeData.focusColor] is also null, then
  /// Theme.of(context).focusColor is used.
  final Color? focusColor;

  /// The highlight color for the button's [InkWell].
  ///
  /// If this property is null, then
  /// ToggleButtonTheme.of(context).highlightColor is used. If
  /// [ToggleButtonsThemeData.highlightColor] is also null, then
  /// Theme.of(context).highlightColor is used.
  final Color? highlightColor;

  /// The splash color for the button's [InkWell].
  ///
  /// If this property is null, then
  /// ToggleButtonTheme.of(context).splashColor is used. If
  /// [ToggleButtonsThemeData.splashColor] is also null, then
  /// Theme.of(context).splashColor is used.
  final Color? splashColor;

  /// The color to use for filling the button when the button has a pointer
  /// hovering over it.
  ///
  /// If this property is null, then
  /// ToggleButtonTheme.of(context).hoverColor is used. If
  /// [ToggleButtonsThemeData.hoverColor] is also null, then
  /// Theme.of(context).hoverColor is used.
  final Color? hoverColor;

  /// A [FocusNode] corresponding to the toggle button.
  ///
  /// Focus is used to determine which widget should be affected by keyboard
  /// events. The focus tree keeps track of which widget is currently focused
  /// on by the user.
  ///
  /// See [FocusNode] for more information about how focus nodes are used.
  final FocusNode? focusNode;

  /// Whether or not to render a border around each toggle button.
  ///
  /// When true, a border with [borderWidth], [borderRadius] and the
  /// appropriate border color will render. Otherwise, no border will be
  /// rendered.
  final bool renderBorder;

  /// Defines the button's size.
  ///
  /// Typically used to constrain the button's minimum size.
  ///
  /// If this property is null, then
  /// BoxConstraints(minWidth: 48.0, minHeight: 48.0) is be used.
  final BoxConstraints? constraints;

  /// The width of the border surrounding each toggle button.
  ///
  /// This applies to both the greater surrounding border, as well as the
  /// borders rendered between toggle buttons.
  ///
  /// To render a hairline border (one physical pixel), set borderWidth to 0.0.
  /// See [BorderSide.width] for more details on hairline borders.
  ///
  /// To omit the border entirely, set [renderBorder] to false.
  ///
  /// If this property is null, then
  /// ToggleButtonTheme.of(context).borderWidth is used. If
  /// [ToggleButtonsThemeData.borderWidth] is also null, then
  /// a width of 1.0 is used.
  final double? borderWidth;

  /// The radii of the border's corners.
  ///
  /// If this property is null, then
  /// ToggleButtonTheme.of(context).borderRadius is used. If
  /// [ToggleButtonsThemeData.borderRadius] is also null, then
  /// the buttons default to non-rounded borders.
  final BorderRadius? borderRadius;

  /// The [TextStyle] to apply to any text in these toggle buttons.
  ///
  /// [TextStyle.color] will be ignored and substituted by [color],
  /// [selectedColor] or [disabledColor] depending on whether the buttons
  /// are active, selected, or disabled.
  final TextStyle? textStyle;

  /// {@macro flutter.material.RawMaterialButton.mouseCursor}
  ///
  /// If this property is null, [MaterialStateMouseCursor.clickable] will be used.
  final MouseCursor? mouseCursor;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ToggleButtonsThemeData toggleButtonsTheme =
        ToggleButtonsTheme.of(context);

    final BorderRadius edgeBorderRadius =
        _getEdgeBorderRadius(toggleButtonsTheme);
    final BorderRadius clipBorderRadius =
        _getClipBorderRadius(toggleButtonsTheme);
    final BorderSide borderSide = _getBorderSide(theme, toggleButtonsTheme);

    final TextStyle currentTextStyle = textStyle ??
        toggleButtonsTheme.textStyle ??
        theme.textTheme.bodyMedium!;

    final BoxConstraints? currentConstraints =
        constraints ?? toggleButtonsTheme.constraints;
    final Size minimumSize = currentConstraints == null
        ? const Size.square(kMinInteractiveDimension)
        : Size(currentConstraints.minWidth, currentConstraints.minHeight);
    final Size? maximumSize = currentConstraints == null
        ? null
        : Size(currentConstraints.maxWidth, currentConstraints.maxHeight);

    final Color currentFillColor;
    if (onPressed != null && value) {
      currentFillColor = selectedFillColor ??
          toggleButtonsTheme.fillColor ??
          theme.colorScheme.primary.withOpacity(0.12);
    } else if (onPressed != null && !value) {
      currentFillColor =
          fillColor ?? theme.colorScheme.surface.withOpacity(0.0);
    } else {
      currentFillColor =
          disabledFillColor ?? theme.colorScheme.surface.withOpacity(0.0);
    }

    final Color currentColor;
    if (onPressed != null && value) {
      currentColor = selectedColor ??
          toggleButtonsTheme.selectedColor ??
          theme.colorScheme.primary;
    } else if (onPressed != null && !value) {
      currentColor = color ??
          toggleButtonsTheme.color ??
          theme.colorScheme.onSurface.withOpacity(0.87);
    } else {
      currentColor = disabledColor ??
          toggleButtonsTheme.disabledColor ??
          theme.colorScheme.onSurface.withOpacity(0.38);
    }
    return _ToggleButtonBorder(
      borderSide: borderSide,
      borderRadius: edgeBorderRadius,
      child: ClipRRect(
        borderRadius: clipBorderRadius,
        child: TextButton(
          focusNode: focusNode != null ? focusNode! : null,
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color?>(currentFillColor),
            foregroundColor: MaterialStatePropertyAll<Color?>(currentColor),
            overlayColor: _ToggleButtonDefaultOverlay(
              selected: onPressed != null && value,
              unselected: onPressed != null && !value,
              colorScheme: theme.colorScheme,
              disabledColor: disabledColor ?? toggleButtonsTheme.disabledColor,
              focusColor: focusColor ?? toggleButtonsTheme.focusColor,
              highlightColor:
                  highlightColor ?? toggleButtonsTheme.highlightColor,
              hoverColor: hoverColor ?? toggleButtonsTheme.hoverColor,
              splashColor: splashColor ?? toggleButtonsTheme.splashColor,
            ),
            elevation: const MaterialStatePropertyAll<double>(0),
            textStyle:
                MaterialStatePropertyAll<TextStyle?>(currentTextStyle.copyWith(
              color: currentColor,
            )),
            padding: const MaterialStatePropertyAll<EdgeInsetsGeometry>(
                EdgeInsets.zero),
            minimumSize: MaterialStatePropertyAll<Size?>(minimumSize),
            maximumSize: MaterialStatePropertyAll<Size?>(maximumSize),
            shape: const MaterialStatePropertyAll<OutlinedBorder>(
                RoundedRectangleBorder()),
            mouseCursor: MaterialStatePropertyAll<MouseCursor?>(mouseCursor),
            visualDensity: VisualDensity.standard,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            animationDuration: kThemeChangeDuration,
            enableFeedback: true,
            alignment: Alignment.center,
            splashFactory: InkRipple.splashFactory,
          ),
          onPressed: onPressed != null
              ? () {
                  onPressed!();
                }
              : null,
          child: child,
        ),
      ),
    );
  }

  BorderSide _getBorderSide(
    ThemeData theme,
    ToggleButtonsThemeData toggleButtonsTheme,
  ) {
    if (!renderBorder) {
      return BorderSide.none;
    }

    final double resultingBorderWidth =
        borderWidth ?? toggleButtonsTheme.borderWidth ?? _defaultBorderWidth;
    if (onPressed != null && value) {
      return BorderSide(
        color: selectedBorderColor ??
            toggleButtonsTheme.selectedBorderColor ??
            theme.colorScheme.onSurface.withOpacity(0.12),
        width: resultingBorderWidth,
      );
    } else if (onPressed != null && !value) {
      return BorderSide(
        color: borderColor ??
            toggleButtonsTheme.borderColor ??
            theme.colorScheme.onSurface.withOpacity(0.12),
        width: resultingBorderWidth,
      );
    } else {
      return BorderSide(
        color: disabledBorderColor ??
            toggleButtonsTheme.disabledBorderColor ??
            theme.colorScheme.onSurface.withOpacity(0.12),
        width: resultingBorderWidth,
      );
    }
  }

  BorderRadius _getEdgeBorderRadius(
    ToggleButtonsThemeData toggleButtonsTheme,
  ) {
    final BorderRadius resultingBorderRadius =
        borderRadius ?? toggleButtonsTheme.borderRadius ?? BorderRadius.zero;

    return resultingBorderRadius;
  }

  BorderRadius _getClipBorderRadius(
    ToggleButtonsThemeData toggleButtonsTheme,
  ) {
    final BorderRadius resultingBorderRadius =
        borderRadius ?? toggleButtonsTheme.borderRadius ?? BorderRadius.zero;
    final double resultingBorderWidth =
        borderWidth ?? toggleButtonsTheme.borderWidth ?? _defaultBorderWidth;

    return BorderRadius.only(
      topLeft: resultingBorderRadius.topLeft -
          Radius.circular(resultingBorderWidth / 2.0),
      bottomLeft: resultingBorderRadius.bottomLeft -
          Radius.circular(resultingBorderWidth / 2.0),
      topRight: resultingBorderRadius.topRight -
          Radius.circular(resultingBorderWidth / 2.0),
      bottomRight: resultingBorderRadius.bottomRight -
          Radius.circular(resultingBorderWidth / 2.0),
    );
  }
}

@immutable
class _ToggleButtonDefaultOverlay extends MaterialStateProperty<Color?> {
  _ToggleButtonDefaultOverlay({
    required this.selected,
    required this.unselected,
    this.colorScheme,
    this.focusColor,
    this.highlightColor,
    this.hoverColor,
    this.splashColor,
    this.disabledColor,
  });

  final bool selected;
  final bool unselected;
  final ColorScheme? colorScheme;
  final Color? focusColor;
  final Color? highlightColor;
  final Color? hoverColor;
  final Color? splashColor;
  final Color? disabledColor;

  @override
  Color? resolve(Set<MaterialState> states) {
    if (selected) {
      if (states.contains(MaterialState.hovered)) {
        return hoverColor ?? colorScheme?.primary.withOpacity(0.04);
      } else if (states.contains(MaterialState.focused)) {
        return focusColor ?? colorScheme?.primary.withOpacity(0.12);
      } else if (states.contains(MaterialState.pressed)) {
        return splashColor ?? colorScheme?.primary.withOpacity(0.16);
      }
    } else if (unselected) {
      if (states.contains(MaterialState.hovered)) {
        return hoverColor ?? colorScheme?.onSurface.withOpacity(0.04);
      } else if (states.contains(MaterialState.focused)) {
        return focusColor ?? colorScheme?.onSurface.withOpacity(0.12);
      } else if (states.contains(MaterialState.pressed)) {
        return splashColor ??
            highlightColor ??
            colorScheme?.onSurface.withOpacity(0.16);
      }
    }
    return null;
  }
}

class _ToggleButtonBorder extends SingleChildRenderObjectWidget {
  const _ToggleButtonBorder({
    required Widget super.child,
    required this.borderSide,
    required this.borderRadius,
  });

  // The width and color of the borders.
  final BorderSide borderSide;

  // The border radii of each corner of the button.
  final BorderRadius borderRadius;

  @override
  _ToggleButtonBorderRenderObject createRenderObject(BuildContext context) =>
      _ToggleButtonBorderRenderObject(
        borderSide,
        borderRadius,
      );

  @override
  void updateRenderObject(
      BuildContext context, _ToggleButtonBorderRenderObject renderObject) {
    renderObject
      ..borderSide = borderSide
      ..borderRadius = borderRadius;
  }
}

class _ToggleButtonBorderRenderObject extends RenderShiftedBox {
  _ToggleButtonBorderRenderObject(
    this._borderSide,
    this._borderRadius, [
    RenderBox? child,
  ]) : super(child);

  // The width and color of the button's top and bottom side borders.
  BorderSide get borderSide => _borderSide;
  BorderSide _borderSide;
  set borderSide(BorderSide value) {
    if (_borderSide == value) {
      return;
    }
    _borderSide = value;
    markNeedsLayout();
  }

  // The border radii of each corner of the button.
  BorderRadius get borderRadius => _borderRadius;
  BorderRadius _borderRadius;
  set borderRadius(BorderRadius value) {
    if (_borderRadius == value) {
      return;
    }
    _borderRadius = value;
    markNeedsLayout();
  }

  static double _maxHeight(RenderBox? box, double width) {
    return box == null ? 0.0 : box.getMaxIntrinsicHeight(width);
  }

  static double _minHeight(RenderBox? box, double width) {
    return box == null ? 0.0 : box.getMinIntrinsicHeight(width);
  }

  static double _minWidth(RenderBox? box, double height) {
    return box == null ? 0.0 : box.getMinIntrinsicWidth(height);
  }

  static double _maxWidth(RenderBox? box, double height) {
    return box == null ? 0.0 : box.getMaxIntrinsicWidth(height);
  }

  @override
  double computeDistanceToActualBaseline(TextBaseline baseline) {
    // The baseline of this widget is the baseline of its child
    return child!.computeDistanceToActualBaseline(baseline)! + borderSide.width;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    return borderSide.width * 2.0 + _maxHeight(child, width);
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    return borderSide.width * 2.0 + _minHeight(child, width);
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    return borderSide.width * 2.0 + _maxWidth(child, height);
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    return borderSide.width * 2.0 + _minWidth(child, height);
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    return _computeSize(
      constraints: constraints,
      layoutChild: ChildLayoutHelper.dryLayoutChild,
    );
  }

  @override
  void performLayout() {
    size = _computeSize(
      constraints: constraints,
      layoutChild: ChildLayoutHelper.layoutChild,
    );
    if (child == null) {
      return;
    }
    final BoxParentData childParentData = child!.parentData! as BoxParentData;
    childParentData.offset = Offset(borderSide.width, borderSide.width);
  }

  Size _computeSize(
      {required BoxConstraints constraints,
      required ChildLayouter layoutChild}) {
    if (child == null) {
      return constraints.constrain(Size(
        borderSide.width + 2.0,
        borderSide.width * 2.0,
      ));
    }

    final BoxConstraints innerConstraints = constraints.deflate(
      EdgeInsets.all(borderSide.width),
    );
    final Size childSize = layoutChild(child!, innerConstraints);

    return constraints.constrain(Size(
      childSize.width + borderSide.width * 2,
      childSize.height + borderSide.width * 2,
    ));
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset);
    final Offset bottomRight = size.bottomRight(offset);
    final Rect outer =
        Rect.fromLTRB(offset.dx, offset.dy, bottomRight.dx, bottomRight.dy);
    final Rect center = outer.deflate(borderSide.width / 2.0);
    const double sweepAngle = math.pi / 2.0;
    final RRect rrect = RRect.fromRectAndCorners(
      center,
      topLeft: (borderRadius.topLeft.x * borderRadius.topLeft.y != 0.0)
          ? borderRadius.topLeft
          : Radius.zero,
      topRight: (borderRadius.topRight.x * borderRadius.topRight.y != 0.0)
          ? borderRadius.topRight
          : Radius.zero,
      bottomLeft: (borderRadius.bottomLeft.x * borderRadius.bottomLeft.y != 0.0)
          ? borderRadius.bottomLeft
          : Radius.zero,
      bottomRight:
          (borderRadius.bottomRight.x * borderRadius.bottomRight.y != 0.0)
              ? borderRadius.bottomRight
              : Radius.zero,
    ).scaleRadii();

    final Rect tlCorner = Rect.fromLTWH(
      rrect.left,
      rrect.top,
      rrect.tlRadiusX * 2.0,
      rrect.tlRadiusY * 2.0,
    );
    final Rect blCorner = Rect.fromLTWH(
      rrect.left,
      rrect.bottom - (rrect.blRadiusY * 2.0),
      rrect.blRadiusX * 2.0,
      rrect.blRadiusY * 2.0,
    );
    final Rect trCorner = Rect.fromLTWH(
      rrect.right - (rrect.trRadiusX * 2),
      rrect.top,
      rrect.trRadiusX * 2,
      rrect.trRadiusY * 2,
    );
    final Rect brCorner = Rect.fromLTWH(
      rrect.right - (rrect.brRadiusX * 2),
      rrect.bottom - (rrect.brRadiusY * 2),
      rrect.brRadiusX * 2,
      rrect.brRadiusY * 2,
    );

    final Paint leadingPaint = borderSide.toPaint();
    // Only one button.
    final Path leadingPath = Path();
    final double startX =
        (rrect.brRadiusX == 0.0) ? outer.right : rrect.right - rrect.brRadiusX;
    leadingPath
      ..moveTo(startX, rrect.bottom)
      ..lineTo(rrect.left + rrect.blRadiusX, rrect.bottom)
      ..addArc(blCorner, math.pi / 2.0, sweepAngle)
      ..lineTo(rrect.left, rrect.top + rrect.tlRadiusY)
      ..addArc(tlCorner, math.pi, sweepAngle)
      ..lineTo(rrect.right - rrect.trRadiusX, rrect.top)
      ..addArc(trCorner, math.pi * 3.0 / 2.0, sweepAngle)
      ..lineTo(rrect.right, rrect.bottom - rrect.brRadiusY)
      ..addArc(brCorner, 0, sweepAngle);
    context.canvas.drawPath(leadingPath, leadingPaint);
  }
}
