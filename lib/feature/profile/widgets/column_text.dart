import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';

class ColumnText extends StatelessWidget {
  final String amount;
  final String title;
  const ColumnText({Key? key,required this.title,required this.amount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * .27,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              amount.toString(),
              style: ubuntuBold.copyWith(fontSize: 17, color: Colors.white),
            ),
            SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
            Text(
              title,
              textAlign: TextAlign.center,
              style: ubuntuMedium.copyWith(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
