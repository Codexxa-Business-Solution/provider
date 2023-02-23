import 'package:demandium_provider/core/helper/core_export.dart';

class TransactionEyeInfoCard extends StatelessWidget {
  final String infoText;
  const TransactionEyeInfoCard({Key? key, required this.infoText}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Dialog(
      elevation: 0,
      backgroundColor: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(infoText,style: ubuntuRegular.copyWith(),)
          ],
        ),
      ),
    );
  }
}