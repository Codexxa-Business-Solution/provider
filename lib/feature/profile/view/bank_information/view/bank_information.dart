import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';

class BankInformation extends StatelessWidget {
  const BankInformation({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: CustomAppBar(title: "bank_information".tr),
      body: SingleChildScrollView(
        child: GetBuilder<BankInfoController>(builder: (bankInfoController){
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                TextFieldTitle(title: "bank_name".tr,requiredMark: true,),
                CustomTextFormField(
                  controller: bankInfoController.bankNameController,
                  hintText: "bank_hint".tr,
                  isShowBorder: true,
                  inputType: TextInputType.text,
                  capitalization: TextCapitalization.words,
                  inputAction: TextInputAction.next,
                ),

                TextFieldTitle(title: "branch_name".tr,requiredMark: true,),
                CustomTextFormField(
                  controller: bankInfoController.branchNameController,
                  hintText: "branch_hint".tr,
                  isShowBorder: true,
                  inputType: TextInputType.text,
                  capitalization: TextCapitalization.words,
                  inputAction: TextInputAction.next,
                ),

                TextFieldTitle(title: "account_no".tr,requiredMark: true,),
                CustomTextFormField(
                  controller: bankInfoController.accountNoController,
                  hintText: "account_no_hint".tr,
                  isShowBorder: true,
                  maxLines: 1,
                  inputType: TextInputType.number,
                  inputAction: TextInputAction.next,
                ),

                TextFieldTitle(title: "account_holder_name".tr,requiredMark: true,),
                CustomTextFormField(
                  controller: bankInfoController.accountHolderNameController,
                  hintText: "enter_account_holder_name".tr,
                  isShowBorder: true,
                  maxLines: 1,
                  capitalization: TextCapitalization.words,
                  inputAction: TextInputAction.done,
                ),

                TextFieldTitle(title: "routing_number".tr,requiredMark: true,),
                CustomTextFormField(
                  controller: bankInfoController.routingNumberController,
                  hintText: "enter_account_routing_number".tr,
                  isShowBorder: true,
                  maxLines: 1,
                  capitalization: TextCapitalization.words,
                  inputAction: TextInputAction.done,
                ),

                 SizedBox(height: 20,),

                bankInfoController.isLoading
                    ?  Center(child: CircularProgressIndicator(color: Theme.of(context).hoverColor))
                    :  CustomButton(
                            onPressed: () =>updateBankInformation(bankInfoController),
                            btnTxt: "save".tr
                )
              ],
            )
          );
        })
      ),
    );
  }

  void updateBankInformation(BankInfoController bankInfoController) {
    if(bankInfoController.bankNameController!.text.isEmpty){
      showCustomSnackBar('bank_hint'.tr);
    }else if(bankInfoController.branchNameController!.text.isEmpty){
      showCustomSnackBar('enter_branch_name'.tr);
    }else if(bankInfoController.accountNoController!.text.isEmpty){
      showCustomSnackBar('enter_account_no'.tr);
    } else if(bankInfoController.accountHolderNameController!.text.isEmpty){
      showCustomSnackBar('enter_account_holder_name'.tr);
    }
    else if(bankInfoController.routingNumberController!.text.isEmpty){
      showCustomSnackBar('enter_account_routing_number'.tr);
    }else{
      bankInfoController.updateBankInfo();
    }
  }
}