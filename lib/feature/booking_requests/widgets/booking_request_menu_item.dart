import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/core/theme/light_theme.dart';

class BookingRequestMenuItem extends GetView<BookingRequestController> {
  const BookingRequestMenuItem({Key? key, required this.title,this.index}) : super(key: key);
  final String title;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      decoration: BoxDecoration(
          color: controller.currentIndex !=index && Get.isDarkMode? Colors.grey.withOpacity(0.2):controller.currentIndex ==index?
          Theme.of(context).primaryColor: Theme.of(context).primaryColor.withOpacity(0.08),
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),

      child: Row(
        children: [
          Image.asset(
            title== "accepted" ? Images.accepted : title== "ongoing"? Images.ongoing: title== "ongoing"
                ? Images.ongoing:title== "completed" ? Images.completed : title== "canceled" ? Images.canceled :Images.pending
            ,fit: BoxFit.cover,
              height:18,
              width:18,
              ),
          SizedBox(width: 5,),
          Text("${title}".tr,textAlign: TextAlign.center,
            style:ubuntuMedium.copyWith(
                fontSize: Dimensions.fontSizeSmall,
                color: controller.currentIndex ==index? light.cardColor : Theme.of(context).textTheme.bodyText1!.color
            ),
          )
        ],
      ),
    );
  }
}