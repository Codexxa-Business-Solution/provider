import 'dart:io';
import 'package:demandium_provider/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/date_converter.dart';
import 'package:demandium_provider/feature/booking_details/controller/pdf_controller.dart';
import 'package:demandium_provider/feature/booking_details/controller/booking_details_controller.dart';
import 'package:demandium_provider/feature/booking_details/model/bookings_details_model.dart';
import 'package:demandium_provider/feature/booking_details/model/invoice.dart';
import 'package:demandium_provider/feature/booking_details/model/supplier.dart';
import 'package:demandium_provider/feature/splash/controller/splash_controller.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:demandium_provider/feature/booking_details/model/provider.dart' as provider;


class PdfInvoiceApi {

  static Future<File> generate(
      BookingDetailsContent bookingDetailsContent,
      List<InvoiceItem> items,
      BookingDetailsController controller
      ) async{
    final pdf = Document();
    final netImage;
    if(Get.find<SplashController>().configModel.content!.logo!=null){
      netImage = await networkImage('${Get.find<SplashController>().configModel.content!.imageBaseUrl}'
          '/business/${Get.find<SplashController>().configModel.content!.logo}');
    }else{
      netImage=null;
    }


    final date = DateTime.now();

    var invoice = Invoice(
      provider: provider.Provider(
        name: bookingDetailsContent.provider!.companyName!,
        address: bookingDetailsContent.provider!.companyAddress!,
      ),
      info: InvoiceInfo(
        date: date,
        description: 'Payment Status : ',
        number: bookingDetailsContent.readableId.toString(),
        paymentStatus: bookingDetailsContent.isPaid == 0 ?"Unpaid": 'Paid',
      ),
      items: items,
    );



    pdf.addPage(MultiPage(
      build: (context) => [
        if(netImage!=null)
        companyImage(netImage,bookingDetailsContent,invoice),
        SizedBox(height: 0.8 * PdfPageFormat.cm),
        buildHeader(invoice,bookingDetailsContent),
        SizedBox(height: 1 * PdfPageFormat.cm),
       // buildTitle(invoice),
        buildInvoice(invoice),
        SizedBox(height: 0.4 * PdfPageFormat.cm),
        buildTotal(bookingDetailsContent,controller),
      ],
        pageFormat: PdfPageFormat.a4.copyWith(marginBottom: 1.5 *PdfPageFormat.cm,marginLeft: 1.5 *PdfPageFormat.cm,marginRight: 1.5 *PdfPageFormat.cm),
      footer: (context) => buildFooter(bookingDetailsContent),
    ));

    return PdfApi.saveDocument(name: 'invoice_${bookingDetailsContent.readableId}.pdf', pdf: pdf);
  }

  static Widget buildHeader(Invoice invoice,BookingDetailsContent bookingDetailsContent) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildCustomerAddress(bookingDetailsContent),
          buildInvoiceInfo(invoice.info,bookingDetailsContent),
        ],
      ),
    ],
  );

  static Widget companyImage(var netImage,BookingDetailsContent bookingDetailsContent,Invoice invoice) {
    return Column(
      children: [
        SizedBox(height: 1 * PdfPageFormat.cm),
        Row(
            children: [
              Container(width: 140,
                height: 140,
                child: pw.Image(netImage),),
            ]
        ),


      ]
    );
  }

  static Widget buildCustomerAddress(BookingDetailsContent bookingDetailsContent) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Invoice Number # ${bookingDetailsContent.readableId!}',
          style: TextStyle(fontWeight: pw.FontWeight.bold,fontSize: 16,)
      ),
      SizedBox(height: 0.5 * PdfPageFormat.cm),
      if(bookingDetailsContent.customer!=null)
      Text('Service Address',style: pw.TextStyle(fontSize: 14,fontWeight: pw.FontWeight.bold)),
      SizedBox(height: 2 * PdfPageFormat.mm),
      if(bookingDetailsContent.customer!=null)
        Text('Customer Name: ${bookingDetailsContent.customer!.firstName} ${bookingDetailsContent.customer!.lastName!}',
      ),
      SizedBox(height: 1 * PdfPageFormat.mm),
      if(bookingDetailsContent.customer!=null && bookingDetailsContent.customer!.email!=null)
        Text('Email: ${bookingDetailsContent.customer!.email}'),
      SizedBox(height: 1 * PdfPageFormat.mm),
      if(bookingDetailsContent.customer!=null && bookingDetailsContent.customer!.phone!=null)
        Text('Phone: ${bookingDetailsContent.customer!.phone}'),
      SizedBox(height: 1 * PdfPageFormat.mm),
      if(bookingDetailsContent.serviceAddress!=null)
        Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: Get.width*.4,
              child: Text('Address: ${bookingDetailsContent.serviceAddress!=null?bookingDetailsContent.serviceAddress!.address:""}',),),
          ]
        ),

      SizedBox(height: 4 * PdfPageFormat.mm),
      Text("Payment Status: ${bookingDetailsContent.isPaid.toString()=='0'?'Unpaid':'Paid'}",
          style: pw.TextStyle(fontSize: 14,fontWeight: pw.FontWeight.bold)
      )
    ],
  );

  static Widget buildInvoiceInfo(InvoiceInfo info,BookingDetailsContent bookingDetailsContent) {

    final data = <String>[
      DateConverter.dateStringMonthYear(info.date),
      info.paymentStatus,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text('Booking Date: ${data[0]}'),
        SizedBox(height: 0.5 * PdfPageFormat.cm),
        if(bookingDetailsContent.serviceman!=null)
        Text('Serviceman Details',style: pw.TextStyle(fontSize: 14,fontWeight: pw.FontWeight.bold)),
        if(bookingDetailsContent.serviceman!=null)
        SizedBox(height: 1 * PdfPageFormat.mm),
        if(bookingDetailsContent.serviceman!=null && bookingDetailsContent.serviceman!.user!=null)
          Text("${bookingDetailsContent.serviceman!.user!.firstName} ${bookingDetailsContent.serviceman!.user!.lastName!}"
          ),
        SizedBox(height: 1 * PdfPageFormat.mm),
        if(bookingDetailsContent.serviceman!=null && bookingDetailsContent.serviceman!.user!.phone!=null)
          Text("${bookingDetailsContent.serviceman!.user!.phone}"
          ),
        SizedBox(height: 0.5 * PdfPageFormat.cm),
        Text('Provider Details',style: pw.TextStyle(fontSize: 14,fontWeight: pw.FontWeight.bold)),
        SizedBox(height: 1 * PdfPageFormat.mm),
        if(bookingDetailsContent.provider!=null && bookingDetailsContent.provider!.companyName!=null)
          Text('${bookingDetailsContent.provider!.companyName}',
          ),
        SizedBox(height: 1 * PdfPageFormat.mm),
        if(bookingDetailsContent.provider!=null && bookingDetailsContent.provider!.companyPhone!=null)
          Text('${bookingDetailsContent.provider!.companyPhone}',
          ),
        SizedBox(height: 1 * PdfPageFormat.mm),
        if(bookingDetailsContent.provider!=null && bookingDetailsContent.provider!.companyAddress!=null)
          Text('${bookingDetailsContent.provider!.companyAddress}',
          ),
      ]
    );
  }


  static Widget buildSupplierAddress(Supplier supplier) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(supplier.name, style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 1 * PdfPageFormat.mm),
      Text(supplier.address),
    ],
  );

  static Widget buildTitle(Invoice invoice) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'INVOICE',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 1 * PdfPageFormat.cm),

    ],
  );

  static Widget buildInvoice(Invoice invoice) {
    final headers = [
      'Description',
      'Unit Price',
      'Quantity',
      'Discount',
      'Tex',
      'Total',
    ];
    final data = invoice.items.map((item) {
      return [
        item.serviceName,
        item.unitPrice,
        item.quantity,
        item.discountAmount,
        item.tax,
        item.unitAllTotal,
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerPadding: EdgeInsets.symmetric(horizontal: 10),
      headerStyle: TextStyle(fontWeight: FontWeight.bold,color: PdfColor.fromHex("f2f2f2")),
      rowDecoration: BoxDecoration(
        color: PdfColors.grey100,
      ),
      headerDecoration: BoxDecoration(
        color: PdfColor.fromHex("4153b3"),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
      ),
      cellHeight: 30,
      columnWidths: {
        0: FixedColumnWidth(Get.width / 4),
      },
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.center,
        2: Alignment.center,
        3: Alignment.center,
        4: Alignment.center,
        5: Alignment.center,
        6: Alignment.centerRight,
      },
    );
  }

  static Widget buildTotal(BookingDetailsContent bookingDetailsContent,BookingDetailsController controller) {


    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          Spacer(flex: 6),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildText(
                  title: 'Sub Total(VAT excluded)',
                  value: controller.allTotalCost.toString(),
                  unite: true,
                ),
                buildText(
                  title: 'Total discount',
                  value: "(-) ${controller.totalDiscountWithCoupon.toStringAsFixed(2)}",
                  unite: true,
                ),
                buildText(
                  title: 'Tax',
                  value: "(+) ${double.tryParse(bookingDetailsContent.totalTaxAmount)!.toStringAsFixed(2)}",
                  unite: true,
                ),
                Divider(),
                buildText(
                  title: 'Grand Total',
                  titleStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  value: double.tryParse(controller.bookingDetailsContent!.totalBookingAmount)!.toStringAsFixed(2),
                  unite: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildFooter(BookingDetailsContent bookingDetailsContent) => 
   Column(
     crossAxisAlignment: CrossAxisAlignment.center,
     children: [
       Text
         (
           'If you require any assistance or have feedback or suggestions about our site, you\n can email us or call us.',
         textAlign: TextAlign.center
       ),
       SizedBox(height: 0.5 * PdfPageFormat.cm),
       Container(
           decoration: BoxDecoration(
               color: PdfColor.fromHex("f2f2f2")
           ),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               Row(),
               SizedBox(height: 1 * PdfPageFormat.mm),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     buildSimpleText(title: '', value: "${Get.find<SplashController>().configModel.content?.businessPhone??""}"),
                     SizedBox(height: 6 * PdfPageFormat.mm),
                     buildSimpleText(title: '', value: "${Get.find<SplashController>().configModel.content?.businessEmail??""}"),
               ],),
               SizedBox(height: 1 * PdfPageFormat.mm),
               Text(AppConstants.BASE_URL),
               SizedBox(height: 1 * PdfPageFormat.mm),
               buildSimpleText(title: '', value: "${Get.find<SplashController>().configModel.content?.footerText??""}"),
               SizedBox(height: 4 * PdfPageFormat.mm),
             ],
           )
       )
     ],
   );

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }
}