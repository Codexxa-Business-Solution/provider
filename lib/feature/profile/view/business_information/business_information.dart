import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';

class BusinessInformation extends StatelessWidget{
  const BusinessInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: CustomAppBar(title: "Business_Information".tr),
      body: SingleChildScrollView(
        child: GetBuilder<UserProfileController>(builder: (userController){
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: userController.providerModel==null?
            Center(child: CircularProgressIndicator(),)
            :Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                TextFieldTitle(title: "identity_type".tr),
                NonEditableTextField(
                  text: userController.providerModel!.content!.providerInfo!.owner!.identificationType!,
                ),

                TextFieldTitle(title: "identity_number".tr),
                NonEditableTextField(
                  text: userController.providerModel!.content!.providerInfo!.owner!.identificationNumber!,
                ),

                SizedBox(height: 20,),
                if(userController.providerModel!.content!.providerInfo!.owner!.identificationImage!=null
                    && userController.providerModel!.content!.providerInfo!.owner!.identificationImage!.length>0
                )GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: ResponsiveHelper.isTab(context)?2:1,
                    crossAxisSpacing: Dimensions.PADDING_SIZE_SMALL,
                    mainAxisSpacing: Dimensions.PADDING_SIZE_SMALL,
                    mainAxisExtent: 200,
                  ),
                  itemBuilder: (context,index){
                    return  InkWell(
                      onTap: ()=> Get.dialog(
                        ImageDialog(
                          imageUrl: '${Get.find<SplashController>().configModel.content!.imageBaseUrl}'
                              '${AppConstants.PROVIDER_IDENTITY_IMAGE_PATH}'
                              '${userController.providerModel!.content!.providerInfo!.owner!.identificationImage![index]}',
                        ),
                      ),
                      child: ClipRRect(borderRadius: BorderRadius.circular(10),
                        child: CustomImage(
                          fit: BoxFit.fill,
                          image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl}'
                              '${AppConstants.PROVIDER_IDENTITY_IMAGE_PATH}'
                             '${userController.providerModel!.content!.providerInfo!.owner!.identificationImage![index]}',
                        ),
                      ),
                    );
                  },
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: userController.providerModel!.content!.providerInfo!.owner!.identificationImage!.length,
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                Row(
                  children: [
                    SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
                    Text(
                      "you_can't_change_this_info".tr,
                      style: ubuntuRegular.copyWith(
                        color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.5),
                        fontSize: Dimensions.fontSizeSmall,
                      ),
                    ),
                    SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
                  ],
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
              ],
            ),
          );
        })
      ),
    );
  }
}