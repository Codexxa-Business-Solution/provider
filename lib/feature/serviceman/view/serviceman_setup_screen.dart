import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/core/theme/light_theme.dart';
import 'package:demandium_provider/feature/serviceman/widget/service_man_list_view.dart';

class ServicemanSetupScreen extends StatelessWidget {
  const ServicemanSetupScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: CustomAppBar(title: "service_man_setup".tr,),
      body: GestureDetector(
        onTap: () => Get.find<ServicemanSetupController>().updateIndex(-1),
        child: GetBuilder<ServicemanSetupController>(
          initState: (_)=> Get.find<ServicemanSetupController>().getAllServicemanList(1,reload: true),
            builder: (servicemanSetUpController){
              return CustomScrollView(
                controller: servicemanSetUpController.scrollController,
                slivers: [
                  servicemanSetUpController.isLoading?
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height*0.82,
                      child: Center(child: CircularProgressIndicator(color: Theme.of(context).hoverColor)
                      )
                    ),
                  )

                  : SliverToBoxAdapter(child:
                    Column(
                      children: [
                        Container(padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("you_have".tr,
                                  style: ubuntuMedium.copyWith(color: Theme.of(context).textTheme.bodyText1!.color)
                              ),
                              Text(" "+servicemanSetUpController.totalServiceman.toString()+" ",
                                  style: ubuntuBold.copyWith(color: Theme.of(context).primaryColor)
                              ),
                              Text(servicemanSetUpController.totalServiceman>1?"service_men".tr:"service_man".tr,
                                  style: ubuntuMedium.copyWith(color: Theme.of(context).textTheme.bodyText1!.color)
                              ),
                            ]
                          ),
                        ),
                        Container(padding: EdgeInsets.symmetric(horizontal: 8), child: ServiceManListview()
                        ),
                        SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT)
                      ],
                    ),
                  )
                ]
              );
          }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Get.find<ServicemanSetupController>().controller!.index=0;
          Get.find<ServicemanSetupController>().getSingleServicemanData(index :-1, fromPage: "others");
          Get.to(()=>AddNewServicemanScreen());
        },
        child: Icon(Icons.add_circle, size: 30, color: light.cardColor)
      )
    );
  }
}



