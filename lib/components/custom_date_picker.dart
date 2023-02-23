import 'package:demandium_provider/core/helper/core_export.dart';

class CustomDatePicker extends StatefulWidget {
  final String title;
  final String text;
  final String image;
  final bool requiredField;
  final Function()? selectDate;
  CustomDatePicker({
    required this.title,
    required this.text,
    required this.image,
    this.requiredField = false,
    required this.selectDate});

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  @override
  Widget build(BuildContext context) {
    return Container(

      child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
        RichText(
          text: TextSpan(
            text: widget.title, style: ubuntuRegular.copyWith(color: Theme.of(context).primaryColor),
            children: <TextSpan>[
              widget.requiredField ? TextSpan(text: '  *', style: ubuntuBold.copyWith(color: Colors.red)) : TextSpan(),
            ],
          ),
        ),

        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

        Container(
          height: 50,
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor,width: 1),
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
          ),
          child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
            Text(widget.text, style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall),),
            InkWell(
                child: SizedBox(width: 20,height: 20,child: Image.asset(widget.image)),
                onTap: widget.selectDate,
            ),
          ],
          ),
        ),
      ],),
    );
  }
}
