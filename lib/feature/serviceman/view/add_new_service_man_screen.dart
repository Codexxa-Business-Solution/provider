import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/feature/serviceman/view/add_new_serviceman_acount_info.dart';

class AddNewServicemanScreen extends StatefulWidget {
  final bool? isEditScreen;
  const AddNewServicemanScreen({Key? key, this.isEditScreen=false}) : super(key: key);
  @override
  State<AddNewServicemanScreen> createState() => _AddNewServicemanScreenState();
}
class _AddNewServicemanScreenState extends State<AddNewServicemanScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: CustomAppBar(title: widget.isEditScreen!?"edit_service_man".tr:"add_new_service_man".tr,),
      body:  GetBuilder<ServicemanSetupController>(builder: (serviceManSetupController){
        return Column(
          children: [
            SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              child: TabBar(
                isScrollable: true,
                unselectedLabelColor: Theme.of(context).disabledColor,
                indicatorColor: Theme.of(context).primaryColor,
                controller: serviceManSetupController.controller,
                labelColor:  Theme.of(context).primaryColor,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                tabs: serviceManSetupController.servicemanDetailsTabs,
                onTap: (int index){
                  switch (index) {
                    case 0: serviceManSetupController.updateTabControllerValue(ServicemanTabControllerState.generalInfo);
                    break;
                    case 1: serviceManSetupController.updateTabControllerValue(ServicemanTabControllerState.accountIno);
                    break;
                  }
                },
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: serviceManSetupController.controller,
                children: [
                  ServiceManGeneralInfo(isFromEditScreen: widget.isEditScreen!,),
                  ServicemanAccountInfo(isFromEditScreen: widget.isEditScreen!,),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
