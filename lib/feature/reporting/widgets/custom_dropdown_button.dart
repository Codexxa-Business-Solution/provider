import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:get/get.dart';

class ReportCustomDropdownButton extends StatefulWidget {
  final String? value;
  final String? label;
  final List<String> items;
  final Function(String? value)? onChanged;
  final Function()? onTap;
  final double? height;
  final double? width;
  final Color? borderColor;
  final Color? dropdownBackgroundColor;
  const ReportCustomDropdownButton({
    Key? key,
    this.value,
    required this.items,
    this.onChanged,
    this.height,
    this.width,
    this.borderColor,
    this.dropdownBackgroundColor,
    this.label, this.onTap
  }) : super(key: key);

  @override
  State<ReportCustomDropdownButton> createState() => _ReportCustomDropdownButtonState();
}

class _ReportCustomDropdownButtonState extends State<ReportCustomDropdownButton> {
  @override
  Widget build(BuildContext context) {
    print(widget.value);
    return Container(
      height: widget.height!=null? widget.height:50,
      width:widget.width!=null? widget.width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
      child: DropdownButtonFormField<String>(
        menuMaxHeight: MediaQuery.of(context).size.height/2,
        dropdownColor: widget.dropdownBackgroundColor!=null?widget.dropdownBackgroundColor:Theme.of(context).cardColor,
        value: widget.value,
        hint: Text('select'.tr,maxLines: 1,overflow: TextOverflow.ellipsis,),
        items: widget.items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value.tr, style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault),maxLines: 1,),

          );
        }).toList(),
        isDense: true,
        onChanged: widget.onChanged,
        isExpanded: true,
        onTap: widget.onTap,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
            borderSide:  BorderSide(color: Theme.of(context).errorColor),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT,
          ),
          labelText: widget.label,
          labelStyle: ubuntuMedium
        ),

      ),
    );
  }
}
