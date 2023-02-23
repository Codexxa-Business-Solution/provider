import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';

class InboxScreen extends GetView<ConversationController> {
  const InboxScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: CustomAppBar(title: 'inbox'.tr),
      body: RefreshIndicator(
        color: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).cardColor,
        onRefresh: ()async=> Get.find<ConversationController>().getChannelList(1, false),

        child: GetBuilder<ConversationController>(
          initState:(_) async{
            String userId = Get.find<SplashController>().configModel.content!.adminDetails!.id!;
               await  Get.find<ConversationController>().createChannel(
                    userId, "",name: '',image: 'image',userType: "super-admin"
                );
            Get.find<ConversationController>().getChannelList(1,false);
          },
          builder: (conversationController){
            if(!conversationController.paginationLoading!)
            return CustomScrollView(controller: conversationController.channelScrollController, slivers: [

              SliverToBoxAdapter(child: Column(children: [
                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                conversationController.adminConversationModel!=null?
                ChannelItem(
                  conversationUserModel: conversationController.adminConversationModel!,
                  channelCreatedTime: conversationController.adminConversationModel!.createdAt,
                  isRead: 1,
                ): SizedBox(),
                controller.channelList!.length==0 && conversationController.adminConversationModel==null?
                SizedBox(height: MediaQuery.of(context).size.height*.82,
                    child: NoDataScreen(text: '',type: NoDataType.CONVERSATION,),
                ): ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.channelList!.length,
                  itemBuilder: (context,index){
                    bool user =
                    ((controller.channelList![index].channelUsers![0].user != null && controller.channelList![index].channelUsers![0].user!.userType !='super-admin')
                        &&  (controller.channelList![index].channelUsers![1].user != null && controller.channelList![index].channelUsers![1].user!.userType !='super-admin'));
                    int? _isRead;
                    if(user){
                      _isRead = controller.channelList![index].channelUsers![0].user!.userType == "provider-admin" ?
                      controller.channelList![index].channelUsers![0].isRead! :
                      controller.channelList![index].channelUsers![1].isRead!;
                    }
                    return user? ChannelItem(
                      conversationUserModel:  controller.channelList![index].channelUsers![0].user!.userType != "provider-admin" ?
                      controller.channelList![index].channelUsers![0] : controller.channelList![index].channelUsers![1],
                      channelCreatedTime: controller.channelList!.elementAt(index).updatedAt!,
                      isRead: _isRead!,
                    ): SizedBox();
                  }
                ),
                conversationController.isLoading! ?
                CircularProgressIndicator(color: Theme.of(context).hoverColor) : SizedBox.shrink(),
              ],),),
              ],
            );
            return  InboxShimmer();
          },
        ),
      ),

      // floatingActionButton: GestureDetector(
      //   onTap: (){
      //     if(isRedundentClick(DateTime.now())){
      //       return;
      //     }
      //     String userId = Get.find<SplashController>().configModel.content!.adminDetails!.id!;
      //
      //     String name = Get.find<SplashController>().configModel.content!.adminDetails!.firstName!+" "
      //         +Get.find<SplashController>().configModel.content!.adminDetails!.lastName!;
      //
      //     String image =Get.find<SplashController>().configModel.content!.imageBaseUrl! +AppConstants.ADMIN_PROFILE_IMAGE_PATH
      //         +Get.find<SplashController>().configModel.content!.adminDetails!.profileImage!;
      //
      //     Get.find<ConversationController>().createChannel(
      //         userId, "",name: name,image: image,userType: "super-admin"
      //     );
      //   },
      //   child: Container(
      //     height: 35,
      //     width: Get.width*.35,
      //     decoration: BoxDecoration(
      //       boxShadow: shadow,
      //       color:  Theme.of(context).primaryColor,
      //       borderRadius: BorderRadius.circular(50)
      //     ),
      //     child: Center(
      //       child: Text('chat_with_admin'.tr,
      //         style: ubuntuMedium.copyWith(
      //           fontSize: Dimensions.fontSizeSmall,
      //           color: light.cardColor,
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
class InboxShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 15,
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      itemBuilder: (context, index) {
        return Shimmer(
          duration: Duration(seconds: 3),
          interval: Duration(seconds: 5),
          color: Theme.of(context).backgroundColor,
          colorOpacity: 0,
          enabled: true,
          child: Padding(
            padding: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_DEFAULT),
            child: Row(children: [
              CircleAvatar(backgroundColor: Theme.of(context).shadowColor,child: Icon(Icons.person), radius: 20),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                  child: Column(children: [
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                        color: Theme.of(context).shadowColor,
                      ),
                    ),
                  ]),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}

