import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';


class HomeScreen extends StatefulWidget {
  final int pageIndex;
  HomeScreen({required this.pageIndex});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController? _pageController;
  int _pageIndex = 0;
  List<Widget>? _screens;
  GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  bool _canExit = GetPlatform.isWeb ? true : false;

  @override
  void initState() {
    super.initState();

    _pageIndex = widget.pageIndex;
    _pageController = PageController(initialPage: widget.pageIndex);


    Future.delayed(Duration(seconds: 1), () {
      setState(() {});
    });

  }




  @override
  Widget build(BuildContext context) {

    _screens = [
      DashBoardScreen(),
      ServiceRequestScreen(),
      AllServicesScreen(),
      Container(child: Text("more".tr),),
    ];


    return WillPopScope(
      onWillPop: () async {
        if (_pageIndex != 0) {
          _setPage(0);
          return false;
        } else {
          if(_canExit) {
            return true;
          }else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('back_press_again_to_exit'.tr, style: TextStyle(color: Colors.white)),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
              margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            ));
            _canExit = true;
            Timer(Duration(seconds: 2), () {
              _canExit = false;
            });
            return false;
          }
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: ResponsiveHelper.isDesktop(context) ? SizedBox() : SafeArea(
          child: Container(

            height: 30 + MediaQuery.of(context).padding.top, alignment: Alignment.center,
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
            decoration: BoxDecoration(
             color: Get.isDarkMode?Theme.of(context).backgroundColor:Theme.of(context).primaryColor,
             boxShadow:[
               BoxShadow(
                 offset: Offset(0, 1),
                 blurRadius: 5,
                 color: Theme.of(context).primaryColor.withOpacity(0.5),
               )]
            ),
            child: Row(children: [
              _getBottomNavItem(0, Images.dashboard, 'dashboard'.tr),
              _getBottomNavItem(1, Images.requests, 'requests'.tr),
              _getBottomNavItem(2, Images.service, 'services'.tr),
              _getBottomNavItem(3, Images.more, 'more'.tr),
            ]),
          ),
        ),
        body: PageView.builder(
          controller: _pageController,
          itemCount: _screens!.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _screens![index];
          },
        ),
      ),
    );
  }

  void _setPage(int pageIndex) {
    if(pageIndex == 3) {
      Get.bottomSheet(MenuScreen(), backgroundColor: Colors.transparent, isScrollControlled: true);
    }else {
      setState(() {
        _pageController!.jumpToPage(pageIndex);
        _pageIndex = pageIndex;
      });
    }
  }

  Widget _getBottomNavItem(int index, String icon, String title) {
    return Expanded(child: InkWell(
      onTap: () => _setPage(index),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [

        icon.isEmpty ? const SizedBox(width: 20, height: 20) : Image.asset(
          icon, width: 17, height: 17,
          color: _pageIndex == index ? Get.isDarkMode ? Theme.of(context).primaryColor : Colors.white : Colors.grey.shade400
        ),
        const SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

        Text(title, style: ubuntuRegular.copyWith(
          fontSize: Dimensions.fontSizeSmall,
          color: _pageIndex == index ? Get.isDarkMode ? Theme.of(context).primaryColor : Colors.white : Colors.grey.shade400
        )),

      ]),
    ));
  }

}
