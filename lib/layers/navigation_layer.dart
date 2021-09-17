part of '../framework.dart';

class NavigationLayer extends StatefulWidget {
  final Widget child;
  final GlobalKey<CustomNavigationRailState> navigationRailKey = GlobalKey();
  final NavigationRailButtons? navigationRailButtons;

  NavigationLayer({Key? key, required this.child, this.navigationRailButtons})
      : super(key: key);

  @override
  NavigationLayerState createState() => NavigationLayerState();
}

class NavigationLayerState extends State<NavigationLayer>
    with TickerProviderStateMixin {
  bool hiddenNavigation = false;
  bool contactButtonExtended = true;

  @override
  void initState() {
    contactButtonExtended = true;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    hiddenNavigation = !ScreenSize.isDesktop(context);
  }

  _switchContactButtonState() {
    setState(() {
      contactButtonExtended = !contactButtonExtended;
    });
  }

  _switchNavigatorRailState() {
    setState(() {
      hiddenNavigation = !hiddenNavigation;
      widget.navigationRailKey.currentState?..extendNavigationRail();
      widget.navigationRailKey.currentState?..closeRail();
    });
  }

  @override
  Widget build(BuildContext context) {
    final customNavigationRail = CustomNavigationRail(
      key: widget.navigationRailKey,
      child: widget.child,
      navigationRailButtons:
          widget.navigationRailButtons ?? defaultNavigationRailButtons,
    );

    return Scaffold(
        // key: scaffoldKey,
        backgroundColor: Colors.black87,
        body: RawMaterialButton(
            mouseCursor: SystemMouseCursors.basic,
            onPressed: () =>
                widget.navigationRailKey.currentState?..closeRail(),
            child: customNavigationRail),
        // floatingActionButtonAnimator: ,
        floatingActionButton: defaultFloatingActionButtons(
          context,
          switchNavigatorRailState: _switchNavigatorRailState,
          switchContactButtonState: _switchContactButtonState,
          hiddenNavigation: hiddenNavigation,
          contactButtonExtended: contactButtonExtended,
        ));
  }
}
