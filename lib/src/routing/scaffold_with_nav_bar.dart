import '../constants/resources.dart';

final scaffoldGlobalKey = GlobalKey();

class ScaffoldWithNavBar extends StatefulHookConsumerWidget {
  const ScaffoldWithNavBar({
    required this.child,
    required this.tabs,
    super.key,
  });

  final Widget child;
  final List<ScaffoldWithNavBarTabItem> tabs;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _HidableBottomNavigationBarState();
}

class _HidableBottomNavigationBarState extends ConsumerState<ScaffoldWithNavBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  int _currentIndex = 0;
  List<ScaffoldWithNavBarTabItem> get tabs => widget.tabs;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _animationController.forward();
  }

  @override
  void didUpdateWidget(covariant ScaffoldWithNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateForCurrentTab();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateForCurrentTab();
  }

  void _updateForCurrentTab() {
    final previousIndex = _currentIndex;
    final location = GoRouter.of(context).location;
    _currentIndex = _locationToTabIndex(location);
    if (previousIndex != _currentIndex) {
      _animationController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  int _locationToTabIndex(String location) {
    final index =
        tabs.indexWhere((tab) => location.startsWith(tab.rootRoutePath));
    return index < 0 ? 0 : index;
  }

  void _onItemTapped(BuildContext context, int tabIndex) {
    if (tabIndex != _currentIndex) {
      context.go(tabs[tabIndex].rootRoutePath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldGlobalKey,
      body: FadeTransition(
        opacity: _animationController,
        child: widget.child,
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        selectedLabelStyle: const TextStyle(fontSize: 11),
        currentIndex: _currentIndex,
        onTap: (i) => _onItemTapped(context, i),
        items: tabs,
      ),
    );
  }
}

/// Representation of a tab item in a [ScaffoldWithNavBar]
class ScaffoldWithNavBarTabItem extends BottomNavigationBarItem {
  /// Constructs an [ScaffoldWithNavBarTabItem].
  const ScaffoldWithNavBarTabItem(
      {required this.rootRoutePath,
      required this.navigatorKey,
      required super.icon,
      super.label});

  /// The initial location/path
  final String rootRoutePath;

  /// Optional navigatorKey
  final GlobalKey<NavigatorState> navigatorKey;
}
