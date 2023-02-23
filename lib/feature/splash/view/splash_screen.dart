import 'package:demandium_provider/data/model/response/notification_body.dart';
import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/feature/language/view/language_screen.dart';

class SplashScreen extends StatefulWidget {
  final NotificationBody? body;
  SplashScreen({@required this.body});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  StreamSubscription<ConnectivityResult>? _onConnectivityChanged;

  @override
  void initState() {
    super.initState();
    bool _firstTime = true;
    _onConnectivityChanged = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if(!_firstTime) {
        bool isNotConnected = result != ConnectivityResult.wifi && result != ConnectivityResult.mobile;
        isNotConnected ? SizedBox() : ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: isNotConnected ? Colors.red : Colors.green,
          duration: Duration(seconds: isNotConnected ? 6000 : 3),
          content: Text(
            isNotConnected ? 'no_connection'.tr : 'connected'.tr,
            textAlign: TextAlign.center,
          ),
        ));
        if(!isNotConnected) {
          _route();
        }
      }
      _firstTime = false;
    });
    Get.find<SplashController>().initSharedData();
    _route();

  }
  @override
  void dispose() {
    super.dispose();
    _onConnectivityChanged!.cancel();
  }
  void _route() {
    Get.find<SplashController>().getConfigData().then((isSuccess) {
      if(isSuccess) {
        Timer(Duration(seconds: 1), () async {

          bool isAvailableUpdate =false;

          String _minimumVersion = "1.1.0";
          double? minimumBaseVersion =1.0;
          double? minimumLastVersion =0;

          String appVersion = AppConstants.APP_VERSION;
          double? baseVersion = double.tryParse(appVersion.substring(0,3));
          double lastVersion=0;
          if(appVersion.length>3){
            lastVersion = double.tryParse(appVersion.substring(4,5))!;
          }


          if(GetPlatform.isAndroid && Get.find<SplashController>().configModel.content!.minimumVersion!=null) {
            _minimumVersion = Get.find<SplashController>().configModel.content!.minimumVersion!.minVersionForAndroid!.toString();
            if(_minimumVersion.length==1){
              _minimumVersion = _minimumVersion+".0";
            }
            if(_minimumVersion.length==3){
              _minimumVersion = _minimumVersion+".0";
            }
            print("minimumVersion: $_minimumVersion");
            minimumBaseVersion = double.tryParse(_minimumVersion.substring(0,3));
            minimumLastVersion = double.tryParse(_minimumVersion.substring(4,5));

            if(minimumBaseVersion!>baseVersion!){
              isAvailableUpdate= true;
            }else if(minimumBaseVersion==baseVersion){
              if(minimumLastVersion!>lastVersion){
                isAvailableUpdate = true;
              }else{
                isAvailableUpdate = false;
              }
            }else{
              isAvailableUpdate = false;
            }
          }
          else if(GetPlatform.isIOS && Get.find<SplashController>().configModel.content!.minimumVersion!=null) {
            _minimumVersion = Get.find<SplashController>().configModel.content!.minimumVersion!.minVersionForIos!;
            if(_minimumVersion.length==1){
              _minimumVersion = _minimumVersion+".0";
            }
            if(_minimumVersion.length==3){
              _minimumVersion = _minimumVersion+".0";
            }
            minimumBaseVersion = double.tryParse(_minimumVersion.substring(0,3));
            if(_minimumVersion.length>3){
              minimumLastVersion = double.tryParse(_minimumVersion.substring(4,5));
            }
            if(minimumBaseVersion!>baseVersion!){
              isAvailableUpdate= true;
            }else if(minimumBaseVersion==baseVersion){
              if(minimumLastVersion!>lastVersion){
                isAvailableUpdate = true;
              }else{
                isAvailableUpdate = false;
              }
            }else{
              isAvailableUpdate = false;
            }
          }
          if(isAvailableUpdate) {
            Get.offNamed(RouteHelper.getUpdateRoute(isAvailableUpdate));
          }
          else {
            PriceConverter.getCurrency(context);
            if(widget.body!=null){
              if(widget.body!.type=='general'){
                Get.toNamed(RouteHelper.getNotificationRoute(fromPage: 'notification'));
              }else if(widget.body!.type=='booking'
                  && widget.body!.bookingId!=null&& widget.body!.bookingId!=""){
                Get.offAllNamed(RouteHelper.getBookingDetailsRoute( widget.body!.bookingId!,"", 'fromNotification'));
              } else if(widget.body!.type=='privacy_policy'){
                Get.toNamed(RouteHelper.getHtmlRoute(page: "privacy-policy",fromPage: 'notification'));
              }else if(widget.body!.type=='terms_and_conditions'){
                Get.toNamed(RouteHelper.getHtmlRoute( page:"terms-and-condition",fromPage: 'notification'));
              }else{
                Get.toNamed(RouteHelper.getNotificationRoute());
              }
            }else{
              if (Get.find<AuthController>().isLoggedIn()) {
                Get.find<AuthController>().updateToken();
                Get.find<UserProfileController>().getProviderInfo()
                    .then((value) => Get.offNamed(RouteHelper.getInitialRoute())
                );
              } else {
                if( Get.find<SplashController>().showIntro()!){
                  Get.to(()=> ChooseLanguageScreen());
                }else{
                  Get.offNamed(RouteHelper.getSignInRoute("LogIn"));
                }
              }
            }
            }
        });
      }else{

      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      key: _globalKey,
      body: GetBuilder<SplashController>(builder: (splashController) {
        return Center(
            child: splashController.hasConnection ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(Get.isDarkMode?Images.demandiumDarkLogo: Images.demandiumLogo, width: 180),
                SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                Text(
                  AppConstants.APP_USER,
                  style: ubuntuBold.copyWith(
                    fontSize: 20,
                    color: Get.isDarkMode?Colors.white70:Theme.of(context).primaryColor,
                  ),
                ),
              ]
            )
            : NoInternetScreen(child: SplashScreen(body: widget.body)
           )
        );
      }),
    );
  }
}
