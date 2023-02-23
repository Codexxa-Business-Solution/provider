import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/feature/auth/widgets/code_picker_widget.dart';

class CustomTextFieldWithCountryCode extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final bool? isPassword;
  final Function(String)? onSubmit;
  final bool? isEnabled;
  final int? maxLines;
  final TextCapitalization? capitalization;
  final Function(String text)? onChanged;
  final String? countryDialCode;
  final Function(CountryCode countryCode)? onCountryChanged;
  final String? Function(String? )? onValidate;
  final Color? fillColor;

  CustomTextFieldWithCountryCode(
      {this.hintText = 'Write something...',
        this.controller,
        this.focusNode,
        this.nextFocus,
        this.isEnabled = true,
        this.inputType = TextInputType.text,
        this.inputAction = TextInputAction.next,
        this.maxLines = 1,
        this.onSubmit,
        this.capitalization = TextCapitalization.none,
        this.isPassword = false,
        this.countryDialCode,
        this.onCountryChanged,
        this.onChanged,
        this.onValidate, this.fillColor,
      });

  @override
  _CustomTextFieldWithCountryCodeState createState() => _CustomTextFieldWithCountryCodeState();
}

class _CustomTextFieldWithCountryCodeState extends State<CustomTextFieldWithCountryCode> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLines,
      controller: widget.controller,
      style: ubuntuRegular.copyWith(
          color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8)),
      textInputAction: widget.inputAction,
      keyboardType: widget.inputType,
      cursorColor: Theme.of(context).primaryColor,
      textCapitalization: widget.capitalization!,
      enabled: widget.isEnabled,
      autofocus: false,
      autofillHints: widget.inputType == TextInputType.name ? [AutofillHints.name]
          : widget.inputType == TextInputType.emailAddress ? [AutofillHints.email]
          : widget.inputType == TextInputType.phone ? [AutofillHints.telephoneNumber]
          : widget.inputType == TextInputType.streetAddress ? [AutofillHints.fullStreetAddress]
          : widget.inputType == TextInputType.url ? [AutofillHints.url]
          : widget.inputType == TextInputType.visiblePassword ? [AutofillHints.password] : null,
      obscureText: widget.isPassword! ? _obscureText : false,
      inputFormatters: widget.inputType == TextInputType.phone ? <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp('[0-9+]'))] : null,
      decoration: InputDecoration(

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide:  BorderSide(color: Get.isDarkMode?Theme.of(context).disabledColor:Theme.of(context).hintColor),
        ),
        enabledBorder: OutlineInputBorder(

          borderRadius: BorderRadius.circular(10.0),
          borderSide:  BorderSide(color: Get.isDarkMode?Theme.of(context).disabledColor:Theme.of(context).hintColor),
        ),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Theme.of(context).primaryColor)),
        hintText: widget.hintText,
        fillColor: widget.fillColor ?? Theme.of(context).cardColor.withOpacity(0.1),
        filled: true,
        hintStyle: ubuntuRegular.copyWith(color: Theme.of(context).hintColor.withOpacity(0.5),fontSize: Dimensions.fontSizeDefault),
        prefixIcon: widget.countryDialCode == null ? SizedBox(width: 110, child: Align(
          alignment: Alignment.centerLeft,
          child: Text(widget.hintText!, style: ubuntuRegular.copyWith(color: Theme.of(context).secondaryHeaderColor)),
        )) : Padding(
          padding:  EdgeInsets.only(left: Get.find<LocalizationController>().isLtr ?20:0,right: Get.find<LocalizationController>().isLtr?0:20),
          child: SizedBox(width: 110, child: CodePickerWidget(
            onChanged: widget.onCountryChanged,
            initialSelection: widget.countryDialCode,
            favorite: [widget.countryDialCode!],
            showDropDownButton: true,
            padding: EdgeInsets.zero,
            showFlagMain: true,
            dialogBackgroundColor: Theme.of(context).cardColor,
            textStyle: ubuntuRegular.copyWith(
              fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).textTheme.bodyText1!.color,
            ),
          )),
        ),
        suffixIcon: widget.isPassword! ? IconButton(
          icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility, color: Theme.of(context).hintColor.withOpacity(0.3)),
          onPressed: _toggle,
        ) : null,
      ),
      onFieldSubmitted: (text) => widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus)
          : widget.onSubmit != null ? widget.onSubmit!(text) : null,
      onChanged: widget.onChanged,
      //validator: widget.onValidate!,
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}