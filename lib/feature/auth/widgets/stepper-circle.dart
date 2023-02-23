import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/core/theme/light_theme.dart';

class CustomStepperCircle extends StatelessWidget {
  final bool isActiveColor;
  final String stepNumber;

  const CustomStepperCircle(
      {Key? key,
      this.isActiveColor = false,
        required this.stepNumber,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      width: 34,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: isActiveColor?Theme.of(context).primaryColor:Theme.of(context).hintColor.withOpacity(0.3),
      ),

      child: Center(
        child: Text(stepNumber,
          style: ubuntuMedium.copyWith(
            fontSize: Dimensions.fontSizeLarge,
            color: Get.isDarkMode? light.cardColor:Theme.of(context).cardColor,
          ),
        ),
      ),
    );
  }
}
