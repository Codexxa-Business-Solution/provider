import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/core/theme/light_theme.dart';

class ChannelItem extends StatelessWidget {
  final String channelCreatedTime;
  final ConversationUserModel conversationUserModel;
  final int isRead;
  const ChannelItem({Key? key, required this.conversationUserModel, required this.channelCreatedTime, required this.isRead}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    String imagePath =
    conversationUserModel.user!.userType=="customer"?AppConstants.CUSTOMER_PROFILE_IMAGE_PATH
        :conversationUserModel.user!.userType=="provider-admin"?AppConstants.PROVIDER_PROFILE_IMAGE_PATH
        :conversationUserModel.user!.userType=="provider-serviceman"?AppConstants.SERVICEMAN_PROFILE_IMAGE_PATH
        :AppConstants.ADMIN_PROFILE_IMAGE_PATH;

    return InkWell(
      onTap:(){
        Get.find<ConversationController>().resetImageFile();
        Get.find<ConversationController>().setChannelId(conversationUserModel.channelId!);
        String name = conversationUserModel.user!.firstName!+ " " +conversationUserModel.user!.lastName!;
        String image = '${Get.find<SplashController>().configModel.content!.imageBaseUrl}'
            '${imagePath}${conversationUserModel.user!.profileImage!}';
        String userType = conversationUserModel.user!.phone!;
        Get.toNamed(RouteHelper.getChatScreenRoute(
            conversationUserModel.channelId!,name,image,userType));
      },

      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
        padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_DEFAULT),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isRead == 0? Theme.of(context).primaryColor : Theme.of(context).cardColor.withOpacity(Get.isDarkMode?0.5:1),
          boxShadow: shadow,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),

            ClipRRect(borderRadius: BorderRadius.circular(50),
              child: CustomImage(height: 50, width: 50,
                image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl}'
                    '${imagePath}${conversationUserModel.user!=null?conversationUserModel.user!.profileImage:''}',
              ),
            ),
            SizedBox(width:Dimensions.PADDING_SIZE_SMALL),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            '${conversationUserModel.user!=null ?
                            conversationUserModel.user!.firstName!+" "+conversationUserModel.user!.lastName!:""}',
                            style: isRead == 0 ?
                            ubuntuBold.copyWith(fontSize: Dimensions.fontSizeDefault, color: light.cardColor) :
                            ubuntuRegular.copyWith(
                              fontSize: Dimensions.fontSizeDefault,
                              color:Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.7), ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 10,),
                      ],
                    ),
                  ),

                  Text('${conversationUserModel.user!=null ?conversationUserModel.user!.userType.toString().tr:""}',
                    style: ubuntuRegular.copyWith(
                      fontSize: Dimensions.fontSizeSmall,
                      color: isRead == 0? light.cardColor : Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6) ,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if(conversationUserModel.user!.userType == "super-admin")
                Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary.withOpacity(.2),
                        borderRadius: BorderRadius.all(Radius.circular(12.0))
                    ),
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL,vertical: 3),
                      child: Text('support'.tr,style: ubuntuMedium.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: Dimensions.fontSizeSmall),),
                    )),
                if(conversationUserModel.user!.userType == "super-admin")
                SizedBox(height: 5,),
                Container(
                  width: Get.width*.25,
                  child: Text("${DateConverter.dateMonthYearTime(DateConverter.isoUtcStringToLocalDate(channelCreatedTime))}",
                      style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall,
                        color: isRead == 0? light.cardColor : Theme.of(context).hintColor,),
                    maxLines: 2,textAlign: TextAlign.center,
                    textDirection: TextDirection.ltr,
                  ),
                ),
              ],
            ),

             SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),
          ],
        ),

      ),
    );
  }
}

