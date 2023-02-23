import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/feature/forgot_password/view/forgot_pass_screen.dart';

class SignInScreen extends StatefulWidget {
  final bool exitFromApp;
  SignInScreen({required this.exitFromApp});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final TextEditingController _passwordController = TextEditingController();
  bool _canExit = GetPlatform.isWeb ? true : false;

  @override
  void initState() {
    super.initState();
    _emailController.text = Get.find<AuthController>().getUserNumber();
    _passwordController.text = Get.find<AuthController>().getUserPassword();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(widget.exitFromApp) {
          if (_canExit) {
            if (GetPlatform.isAndroid) {
              SystemNavigator.pop();
            } else if (GetPlatform.isIOS) {
              exit(0);
            } else {
              Navigator.pushNamed(context, RouteHelper.getInitialRoute());
            }
            return Future.value(false);
          } else {
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
            return Future.value(false);
          }
        }else {
          return true;
        }
      },

      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SafeArea(child: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
            child: Center(
              child: Container(
                child: GetBuilder<AuthController>(builder: (authController) {

                  return Column(children: [
                    Image.asset(Get.isDarkMode?Images.demandiumDarkLogo:Images.demandiumLogo,width: Dimensions.AUTH_LOGO,),
                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),

                    SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                    CustomTextField(
                      title: 'email_or_phone'.tr,
                      hintText: 'enter_email_or_password'.tr,
                      controller: _emailController,
                      focusNode: _emailFocus,
                      nextFocus: _passwordFocus,
                      inputType: TextInputType.emailAddress,
                    ),

                    SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                    CustomTextField(
                      title: 'password'.tr,
                      hintText: '********'.tr,
                      controller: _passwordController,
                      focusNode: _passwordFocus,
                      inputType: TextInputType.visiblePassword,
                      isPassword: true,
                      inputAction: TextInputAction.done,
                    ),

                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                    Row(mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: ListTile(
                            onTap: () => authController.toggleRememberMe(),
                            title: Row(
                              children: [
                                SizedBox(
                                  width: 20.0,
                                  child: Checkbox(
                                    activeColor: Theme.of(context).primaryColor,
                                    value: authController.isActiveRememberMe,
                                    onChanged: (bool? isChecked) => authController.toggleRememberMe(),
                                  ),
                                ),
                                SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                                Text(
                                  'remember_me'.tr,
                                  style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault),
                                ),
                              ],
                            ),
                            contentPadding: EdgeInsets.zero,
                            dense: true,
                            horizontalTitleGap: 0,
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(minimumSize: Size(1, 40),backgroundColor: Theme.of(context).backgroundColor),
                          onPressed: () => Get.to(ForgetPassScreen()),
                          child: Text('${'forgot_password?'.tr}', style: ubuntuRegular.copyWith(
                            fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8),)
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                    !authController.isLoading! ?
                    CustomButton(btnTxt: 'sign_in'.tr, onPressed:  () => _login(authController) )
                    : Center(child: CircularProgressIndicator(
                            color: Theme.of(context).hoverColor)
                    ),

                    Get.find<SplashController>().configModel.content?.providerSelfRegistration =="1" ?
                    Column(
                      children: [
                        SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

                        Text("or".tr, style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                              color: Theme.of(context).textTheme.bodyText1!.color,)),
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('do_not_have_an_account'.tr, style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                                    color: Theme.of(context).colorScheme.primary)),
                            TextButton(
                              style: TextButton.styleFrom(minimumSize: Size(1, 40),
                                  backgroundColor: Theme.of(context).backgroundColor),
                              onPressed: () => Get.toNamed(RouteHelper.signUp),

                              child:Text('register_here'.tr,
                                style: ubuntuRegular.copyWith(decoration: TextDecoration.underline,
                                    //color: Colors.black,
                                     color: Theme.of(context).colorScheme.tertiary.withOpacity(.8),
                                    fontSize: Dimensions.fontSizeDefault
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ) :SizedBox.shrink(),

                  ]);
                }),
              ),
            ),
          ),
        )),
      ),
    );
  }

  void _login(AuthController authController) async {

    String _emailOrPhone = _emailController.text.trim();
    String _password = _passwordController.text.trim();

    if (_emailOrPhone.isEmpty) {
      showCustomSnackBar('email_or_phone_is_invalid'.tr);
    } else if (_password.isEmpty) {
      showCustomSnackBar('enter_password'.tr);
    }else if (_password.length < 8) {
      showCustomSnackBar('password_should_be'.tr);
    }else {
      authController.login(_emailOrPhone,_password);
    }
  }
}

