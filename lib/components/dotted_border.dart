import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';

class DottedBorderBox extends StatelessWidget {
  final double? height;
  final double? width;
  final Function() onTap;
  const DottedBorderBox({Key? key, required this.onTap, this.height=100, this.width=100}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      dashPattern: [8, 4],
      strokeWidth: 1,
      borderType: BorderType.RRect,
      color: Colors.grey,
      radius: Radius.circular(10),
      child: GestureDetector(
        onTap: onTap,
        child: Container(height: height, width: width,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.cloud_upload_rounded,
                  color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6),
                  size: 30,
                ),
                SizedBox(height: 5,),
                Text("upload_file".tr,
                  style: ubuntuMedium.copyWith(fontSize: 12,
                    color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
