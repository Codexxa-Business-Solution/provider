import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';


class NotificationScreen extends StatefulWidget {
  final String? fromNotificationPage;
  const NotificationScreen({Key? key,this.fromNotificationPage}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<NotificationController>().getNotifications(1,);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: CustomAppBar(
          title: "notifications".tr,
          onPressed:
          widget.fromNotificationPage!='null' || widget.fromNotificationPage!=null?
              (){
            Get.offAllNamed(RouteHelper.initial);
          }:null
      ),
      body: GetBuilder<NotificationController>(builder: (controller) {
        return controller.isLoading? CustomShimmer(): controller.dateList.length == 0 ?
        NoDataScreen(text: 'empty_notifications'.tr,type: NoDataType.NOTIFICATION,):
        RefreshIndicator(
          color: Theme.of(context).primaryColor,
          backgroundColor: Theme.of(context).cardColor,
          onRefresh: () async {
            controller.getNotifications(1);
          },
          child: Column(
            children: [
              Expanded(
                child: CustomScrollView(controller: controller.scrollController, slivers: [
                   SliverToBoxAdapter(child: Column(children: [
                     ListView.builder(itemBuilder: (context, index0) {
                       return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                         Padding(padding:  EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                           vertical: Dimensions.PADDING_SIZE_DEFAULT),
                           child: Text(
                             Get.find<NotificationController>().dateList[index0].toString(),
                             style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeLarge,
                                 color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.7)
                             ),
                             textDirection: TextDirection.ltr,
                           )
                         ),
                         Container(
                           decoration: BoxDecoration(
                            boxShadow: Get.isDarkMode? null:[
                              BoxShadow(
                                offset: Offset(0, 1),
                                blurRadius: 3,
                                color: Colors.black.withOpacity(0.08),
                              )],
                             color: Theme.of(context).cardColor,
                           ),

                           child: ListView.separated(itemBuilder: (context, index1) {
                             return InkWell(
                               onTap: () => showDialog(context: context, builder: (ctx)  =>
                                   ImageDialog(
                                     imageUrl:'${Get.find<SplashController>().configModel.content!.imageBaseUrl}'
                                       '${AppConstants.PUSH_NOTIFICATION_IMAGE_PATH}'
                                       '${controller.notificationList[index0][index1].coverImage}',
                                     title: "${controller.notificationList[index0][index1].title.toString().trim()}",
                                     subTitle: "${controller.notificationList[index0][index1].description}",
                                   )
                               ),
                               child: Container(
                                 padding:  EdgeInsets.symmetric(
                                     horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                                     vertical: Dimensions.PADDING_SIZE_SMALL
                                 ),
                                 child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                                   Row(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [

                                       ClipRRect(
                                         borderRadius: BorderRadius.circular(50),
                                         child: CustomImage(
                                             image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl}'
                                                 '${AppConstants.PUSH_NOTIFICATION_IMAGE_PATH}'
                                                 '${controller.notificationList[index0][index1].coverImage}',
                                             height: 30,
                                           width: 30,
                                           fit: BoxFit.cover,
                                         )
                                       ),

                                       SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT,),
                                       Expanded(
                                         child: Column(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                             Text("${controller.notificationList[index0][index1].title.toString().trim()}",
                                               style: ubuntuMedium.copyWith(color: Theme.of(context).
                                               textTheme.bodyText1!.color!.withOpacity(0.7) ,
                                                 fontSize: Dimensions.fontSizeDefault,
                                               ),
                                             ),
                                             SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                                             Text("${controller.notificationList[index0][index1].description}",
                                               style: ubuntuRegular.copyWith(color: Theme.of(context).
                                                  textTheme.bodyText1!.color!.withOpacity(0.5) ,
                                                 fontSize: Dimensions.fontSizeDefault,
                                               ),
                                               maxLines:2,
                                             ),
                                           ],
                                         ),
                                       ),

                                       Container(
                                         height: 40,
                                         width: 60,
                                         child: Row(
                                           mainAxisAlignment: MainAxisAlignment.end,
                                           children: [
                                             Text("${DateConverter.convertStringTimeToDate(
                                               DateConverter.isoUtcStringToLocalDate(
                                               controller.notificationList[index0][index1].createdAt))}",
                                             ),
                                           ],
                                         ),
                                       ),
                                     ],
                                   ),
                                   ],
                                 )
                               ),
                             );},
                             shrinkWrap: true,
                             physics: NeverScrollableScrollPhysics(),
                             itemCount: controller.notificationList[index0].length,
                             separatorBuilder: (BuildContext context, int index) {
                             return Divider();
                             },
                           ),
                         )
                         ],
                       );},
                       shrinkWrap: true,
                       physics: NeverScrollableScrollPhysics(),
                       itemCount: controller.dateList.length,
                     ),

                     SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE,)
                   ],
                   ))
                 ]
                ),
              ),
              controller.paginationLoading?
              CircularProgressIndicator(color: Theme.of(context).hoverColor,
              ):SizedBox.shrink(),
            ],
          ),
        );
        },
      )
    );
  }
}




