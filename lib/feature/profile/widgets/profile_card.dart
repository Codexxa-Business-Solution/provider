import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';

class ProfileCardItem extends StatelessWidget {
  final String leadingIcon;
  final bool? isDarkItem;
  final String title;
  final IconData? trailingIcon;

  const ProfileCardItem({Key? key,this.trailingIcon=Icons.arrow_forward_ios,required this.title,required this.leadingIcon,this.isDarkItem=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: shadow,
      ),

      child: Center(
        child: ListTile(
          horizontalTitleGap: Dimensions.PADDING_SIZE_EXTRA_SMALL,
          title: Text(title.tr),
          trailing: Icon(trailingIcon,size: 15,color: Theme.of(context).primaryColor,),
          leading: Image.asset(leadingIcon,height: 20,width: 20,fit:BoxFit.cover),
        ),
      ),
    );
  }
}
