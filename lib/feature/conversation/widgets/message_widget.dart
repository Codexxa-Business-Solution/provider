import 'dart:ui';
import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';

class ConversationBubble extends StatefulWidget {
  final ConversationData conversationData;
  final bool isRightMessage;

  ConversationBubble({required this.conversationData, required this.isRightMessage});

  @override
  State<ConversationBubble> createState() => _ConversationBubbleState();
}

class _ConversationBubbleState extends State<ConversationBubble> {
  ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();
    IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      setState((){ });
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, DownloadTaskStatus status, int progress) {
    final SendPort? send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {

    String imagePath = widget.conversationData.user!.userType=="customer"?AppConstants.CUSTOMER_PROFILE_IMAGE_PATH
        :widget.conversationData.user!.userType=="provider-admin"?AppConstants.PROVIDER_PROFILE_IMAGE_PATH
        :widget.conversationData.user!.userType=="provider-serviceman"?AppConstants.SERVICEMAN_PROFILE_IMAGE_PATH
        :AppConstants.ADMIN_PROFILE_IMAGE_PATH;

    return Column(crossAxisAlignment: widget.isRightMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start, children: [
      Padding(padding: widget.isRightMessage ?
        EdgeInsets.fromLTRB(20, 5, 5, 5) : EdgeInsets.fromLTRB(5, 5, 20, 5),
        child: Column(
          crossAxisAlignment: widget.isRightMessage ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            widget.conversationData.user!=null?
            Row(
              mainAxisAlignment: widget.isRightMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                Text(widget.isRightMessage ?
                Get.find<UserProfileController>().providerModel!.content!.providerInfo!.companyName! :
                widget.conversationData.user!.firstName!+' '+widget.conversationData.user!.lastName!,
                  style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                  ),
                ),
              ],
            ):SizedBox(),
            SizedBox(height:Dimensions.fontSizeExtraSmall),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: widget.isRightMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                widget.isRightMessage ?
                SizedBox() :
                Column(
                  children: [
                    ClipRRect(borderRadius: BorderRadius.circular(50),
                      child: CustomImage(
                        height: 30,
                        width: 30,
                        image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl}''${imagePath}'
                            '${widget.conversationData.user!=null?widget.conversationData.user!.profileImage:''}',
                      ),
                    ),
                  ],
                ),

                SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),
                Flexible(
                  child: Column(crossAxisAlignment: widget.isRightMessage?CrossAxisAlignment.end:CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min, children: [
                      if(widget.conversationData.message != null) Flexible(
                        child: Container(
                          decoration: BoxDecoration(
                            color: widget.isRightMessage?ColorResources.getRightBubbleColor():ColorResources.getLeftBubbleColor(),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(child: Padding(
                            padding: EdgeInsets.all(widget.conversationData.message != null?Dimensions.PADDING_SIZE_DEFAULT:0),
                            child: Text(widget.conversationData.message??''),
                          ),),
                        ),
                      ),
                      if( widget.conversationData.conversationFile!.length > 0) SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                      widget.conversationData.conversationFile!.length > 0?
                      Column(
                        children: [
                          Directionality(
                            textDirection: widget.isRightMessage  && Get.find<LocalizationController>().isLtr?
                            TextDirection.rtl: !Get.find<LocalizationController>().isLtr
                                && !widget.isRightMessage? TextDirection.rtl: TextDirection.ltr,
                            child: GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 1,
                                crossAxisCount: ResponsiveHelper.isTab(context)?5:3,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5,
                              ),
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: widget.conversationData.conversationFile!.length,
                              itemBuilder: (BuildContext context, index){
                                String _imageUrl = '';
                                try{
                                 _imageUrl = '${Get.find<SplashController>().configModel.content!.imageBaseUrl}'
                                     '${AppConstants.CONVERSATION_IMAGE_PATH}'
                                     '${widget.conversationData.conversationFile![index].fileName ?? ''}';
                                }catch(e) {

                                }
                                return widget.conversationData.conversationFile![index].fileType == 'png'
                                || widget.conversationData.conversationFile![index].fileType == 'jpg'?
                                InkWell(
                                  onTap: () => showDialog(context: context, builder: (ctx)  =>
                                  ImageDialog(
                                    imageUrl:
                                    '${Get.find<SplashController>().configModel.content!.imageBaseUrl}'
                                    '${AppConstants.CONVERSATION_IMAGE_PATH}'
                                    '${widget.conversationData.conversationFile![index].fileName ?? ''}'
                                  ),),

                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child:
                                    FadeInImage.assetNetwork(
                                      placeholder: Images.placeholder,
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                      image: _imageUrl,
                                      imageErrorBuilder: (c, o, s) =>
                                      Image.asset(
                                        Images.placeholder,
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.cover
                                      ),
                                    ),
                                  ),
                                ) : InkWell(
                                  onTap : () async {
                                    final status = await Permission.storage.request();
                                    if(status.isGranted){
                                      Directory? directory = Directory('/storage/emulated/0/Download');
                                      if (!await directory.exists()) directory = await getExternalStorageDirectory();
                                      Get.find<ConversationController>().downloadFile(
                                        '${Get.find<SplashController>().configModel.content!.imageBaseUrl}'
                                        '${AppConstants.CONVERSATION_IMAGE_PATH}'
                                        '${widget.conversationData.conversationFile![index].fileName ?? ''}',directory!.path,
                                      );
                                    }
                                  },
                                  child: Container(height: 50,width: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Get.isDarkMode? Theme.of(context).cardColor: Colors.grey.withOpacity(0.2)
                                    ),
                                    child: Stack(
                                      children: [
                                       Center(
                                         child: Container(
                                           child: Image.asset(Images.folder),
                                           padding: EdgeInsets.symmetric(
                                           horizontal: Dimensions.PADDING_SIZE_SMALL,

                                           ),
                                         )
                                       ),
                                      Center(
                                        child: Text(
                                          '${widget.conversationData.conversationFile![index].fileName}'
                                          .substring(widget.conversationData.conversationFile![index].fileName!.length-7
                                          ),
                                          maxLines: 5,
                                           overflow: TextOverflow.clip,
                                        ),
                                      ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ):SizedBox.shrink(),
                    ],
                  ),
                ),

                SizedBox(width: 10,),
                widget.isRightMessage ?
                ClipRRect(borderRadius: BorderRadius.circular(50),
                    child: CustomImage(height: 30, width: 30,
                        image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl}'
                            '${imagePath}${Get.find<UserProfileController>().providerModel!
                            .content!.providerInfo!.logo}'
                    )
                )
                    : SizedBox(),
              ],
            ),
          ],
        ),
      ),

        Padding(
            padding: widget.isRightMessage ? EdgeInsets.fromLTRB(5, 0, 50, 5) : EdgeInsets.fromLTRB(50, 0, 5, 5),
            child: Text(
                "${DateConverter.dateMonthYearTime(DateConverter.isoUtcStringToLocalDate(widget.conversationData.createdAt!))}",
                textDirection: TextDirection.ltr,
              style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall)
            )
        ),

      ],
    );
  }
}


