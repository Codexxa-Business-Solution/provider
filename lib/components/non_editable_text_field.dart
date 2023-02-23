import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';

class NonEditableTextField extends StatelessWidget {
  final String ? text;

  NonEditableTextField({Key? key,this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL,vertical: Dimensions.PADDING_SIZE_DEFAULT),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
            color: Theme.of(context).hintColor.withOpacity(.1),
            border: Border.all(color: Theme.of(context).hintColor.withOpacity(.5),width: 1)),
        child: Row(
          children: [
            SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),
            Text(text!.tr,
              style: ubuntuMedium.copyWith(
                color: Theme.of(context).textTheme.bodyText1!.color,
                fontSize: Dimensions.fontSizeDefault),
            ),
          ],
        )
    );
  }
}