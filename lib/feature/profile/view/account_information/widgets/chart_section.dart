import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';


class TransactionChart extends StatelessWidget {
  const TransactionChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
        vertical: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: Container(
        height: 250,
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.lightBlue.shade100,width:Get.isDarkMode? 0.6:1),
        ),
        child: TransactionPieChart(),
      ),
    );
  }
}
