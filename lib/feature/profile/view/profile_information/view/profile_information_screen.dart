import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/feature/profile/view/profile_information/widgets/general_info.dart';
import 'package:demandium_provider/feature/profile/view/profile_information/widgets/account_info.dart';

class ProfileInformationScreen extends StatefulWidget {
  const ProfileInformationScreen({Key? key}) : super(key: key);
  @override
  State<ProfileInformationScreen> createState() => _ProfileInformationScreenState();
}
class _ProfileInformationScreenState extends State<ProfileInformationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<UserProfileController>().getZoneList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: CustomAppBar(title: "profile_information".tr,),
      body:  DefaultTabController(
        length: 2,
        child: Column(
          children: [
            SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.blue
                  )
                ),
              ),
              child: TabBar(
                unselectedLabelColor: Colors.grey,
                isScrollable: true,
                indicatorColor: Theme.of(context).primaryColor,
                labelColor:  Theme.of(context).primaryColor,
                labelStyle: ubuntuMedium,
                tabs:  [
                  SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.width*.4,
                    child:Center(
                      child: Text("general_info".tr),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.width*.4,
                    child:  Center(
                      child: Text("account_info".tr),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  GeneralInfo(),
                  AccountInfo()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
