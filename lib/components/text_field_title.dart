import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';
class TextFieldTitle extends StatelessWidget {
  final String title;
  final bool requiredMark;
  const TextFieldTitle({Key? key, required this.title, this.requiredMark = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL,top: Dimensions.PADDING_SIZE_DEFAULT),
      child: RichText(
          text:
            TextSpan(children: <TextSpan>[
                TextSpan(text: title, style: ubuntuRegular.copyWith(color: Theme.of(Get.context!).textTheme.bodyText1!.color!.withOpacity(0.9))),
                TextSpan(text: requiredMark?' *':"", style: ubuntuRegular.copyWith(color: Colors.red)),
          ])),
    );
  }
}
