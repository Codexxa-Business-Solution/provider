import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';

class HtmlViewerScreen extends StatefulWidget {
  final HtmlType? htmlType;
  final String? fromNotificationPage;
  HtmlViewerScreen({@required this.htmlType,this.fromNotificationPage});

  @override
  State<HtmlViewerScreen> createState() => _HtmlViewerScreenState();
}
class _HtmlViewerScreenState extends State<HtmlViewerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: CustomAppBar(
        title: widget.htmlType == HtmlType.TERMS_AND_CONDITION ? 'terms_conditions'.tr
            : widget.htmlType == HtmlType.ABOUT_US ? 'about_us'.tr
            : widget.htmlType == HtmlType.PRIVACY_POLICY ? 'privacy_policy'.tr
            : widget.htmlType == HtmlType.REFUND_POLICY ? 'refund_policy'.tr
            : widget.htmlType == HtmlType.CANCELLATION_POLICY ? 'cancellation_policy'.tr
            : 'no_data_found'.tr,
        onPressed:
        widget.fromNotificationPage!='null'?
            (){
          Get.offAllNamed(RouteHelper.initial);
        }:null
      ),
      body: GetBuilder<HtmlViewController>(
        initState: (state){
          Get.find<HtmlViewController>().getPagesContent();
        },
        builder: (htmlViewController){
          String? _data;
          if(htmlViewController.pagesContent != null){
            _data = widget.htmlType == HtmlType.TERMS_AND_CONDITION ? htmlViewController.pagesContent!.termsAndConditions!.liveValues!
                : widget.htmlType == HtmlType.ABOUT_US ? htmlViewController.pagesContent!.aboutUs!.liveValues!
                : widget.htmlType == HtmlType.PRIVACY_POLICY ? htmlViewController.pagesContent!.privacyPolicy!.liveValues!
                : widget.htmlType == HtmlType.REFUND_POLICY ? htmlViewController.pagesContent!.refundPolicy!.liveValues!
                : widget.htmlType == HtmlType.CANCELLATION_POLICY ? htmlViewController.pagesContent!.cancellationPolicy!.liveValues!
                : null;

            if(_data != null) {
              _data = _data.replaceAll('href=', 'target="_blank" href=');
              return Center(
                child: Container(
                  width: Dimensions.WEB_MAX_WIDTH,
                  height: MediaQuery.of(context).size.height,
                  color: Theme.of(context).cardColor.withOpacity(Get.isDarkMode?0.5:1),
                  child:SingleChildScrollView(
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    physics: BouncingScrollPhysics(),
                    child: HtmlWidget(
                      _data,
                      textStyle: ubuntuRegular.copyWith(
                        color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.7),
                      ),
                    ),
                  ),
                ),
              );
            }else{
              return SizedBox();
            }
          }else{
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }
}