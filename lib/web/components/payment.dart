// import 'package:easy_upi_payment/easy_upi_payment.dart';
// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// import '../../common.dart/providers/main_provider.dart';

// class PayView extends HookConsumerWidget {
//   const PayView({super.key});
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     ref.listen<MainState>(
//       mainStateProvider,
//       (previous, next) {
//         switch (next) {
//           case MainState.initial:
//           case MainState.loading:
//             break;
//           case MainState.success:
//             final model =
//                 ref.read(mainStateProvider.notifier).transactionDetailModel;
//             showDialog<void>(
//               context: context,
//               builder: (BuildContext context) => AlertDialog(
//                 title: const Icon(
//                   Icons.check_circle,
//                   color: Colors.green,
//                   size: 54,
//                 ),
//                 content: Table(
//                   border: TableBorder.all(),
//                   defaultVerticalAlignment: TableCellVerticalAlignment.middle,
//                   children: [
//                     TableRow(
//                       children: [
//                         const Padding(
//                           padding: EdgeInsets.all(8.0),
//                           child: Text('Txn Id:'),
//                         ),
//                         Text('  ${model?.transactionId}  '),
//                       ],
//                     ),
//                     TableRow(
//                       children: [
//                         const Padding(
//                           padding: EdgeInsets.all(8.0),
//                           child: Text('Response Code:'),
//                         ),
//                         Text('  ${model?.responseCode}  '),
//                       ],
//                     ),
//                     TableRow(
//                       children: [
//                         const Padding(
//                           padding: EdgeInsets.all(8.0),
//                           child: Text('Ref No:'),
//                         ),
//                         Text('  ${model?.approvalRefNo}  '),
//                       ],
//                     ),
//                     TableRow(
//                       children: [
//                         const Padding(
//                           padding: EdgeInsets.all(8.0),
//                           child: Text('Txn Ref Id:'),
//                         ),
//                         Text('  ${model?.transactionRefId}  '),
//                       ],
//                     ),
//                     TableRow(
//                       children: [
//                         const Padding(
//                           padding: EdgeInsets.all(8.0),
//                           child: Text('Amount :'),
//                         ),
//                         Text('  ${model?.amount}  '),
//                       ],
//                     ),
//                   ],
//                 ),
//                 actions: <Widget>[
//                   TextButton(
//                     onPressed: () => Navigator.pop(context),
//                     child: const Text('Okay'),
//                   ),
//                 ],
//               ),
//             );
//             break;
//           case MainState.error:
//             showDialog<void>(
//               context: context,
//               builder: (BuildContext context) => AlertDialog(
//                 title: const Icon(
//                   Icons.cancel,
//                   color: Colors.red,
//                   size: 54,
//                 ),
//                 content: const Text(
//                   'Transaction Failed!',
//                   textAlign: TextAlign.center,
//                 ),
//                 actions: <Widget>[
//                   TextButton(
//                     onPressed: () => Navigator.pop(context),
//                     child: const Text('Okay'),
//                   ),
//                 ],
//               ),
//             );
//             break;
//         }
//       },
//     );

//     // final appStorage = ref.read(appStorageProvider);W
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         ElevatedButton(
//           onPressed: () {
//             // if (formKeyRef.value.currentState!.validate()) {
//             ref.read(mainStateProvider.notifier).startPayment(
//                   const EasyUpiPaymentModel(
//                       payeeVpa: '9640587007@ibl',
//                       payeeName: "Ruchulu",
//                       amount: 200,
//                       description: "order"),
//                 );
//           },
//           // },
//           style: ButtonStyle(
//             fixedSize: MaterialStateProperty.all(const Size.fromHeight(42)),
//             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//               RoundedRectangleBorder(
//                 borderRadius:
//                     BorderRadius.circular(50), // Adjust the radius as needed
//               ),
//             ),
//           ),
//           child: const Text('Pay Now'),
//         ),
//       ],
//     );
//   }
// }
