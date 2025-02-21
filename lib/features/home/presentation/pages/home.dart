// import 'package:flutter/material.dart';

// class Home extends StatelessWidget {
//   const Home({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           DefaultTextFormField(
//               onSubmitted: (p0) async {
//                 print(p0);
//                 if (p0?.isNotEmpty ?? false) {
//                   await SystemChannels.textInput.invokeMethod("TextInput.hide");
//                   if (!context.mounted) return;
//                   await Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => ResultsPage(
//                         word: p0!.toLowerCase(),
//                       ),
//                     ),
//                   );
//                 }
//               },
//               focusNode: FocusNode(),
//               hint: "Search any word",
//               onChanged: (value) {
//                 final Map<String, dynamic> params = {
//                   "text": value?.toLowerCase(),
//                   "decodedWords": words
//                 };
//                 print(params);
//                 wordSuggestBloc.add(
//                   WordSuggestEvent(
//                     params: params,
//                   ),
//                 );
//                 if (value?.isNotEmpty ?? false) {
//                   isSearchEmpty = true;
//                   setState(() {});
//                 } else {
//                   isSearchEmpty = false;
//                   setState(() {});
//                 }
//               },
//               showSuffixIcon: isSearchEmpty,
//               controller: searchController,
//               suffixOnTap: () {
//                 searchController.clear();
//                 isSearchEmpty = false;
//                 setState(() {});
//               },
//             ),
//         ],
//       ),
//     );
//   }
// }