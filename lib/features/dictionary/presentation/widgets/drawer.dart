import 'package:flutter/material.dart';
import 'package:riverpod_learn/features/database/entity/dicitionary.dart';
import 'package:riverpod_learn/features/dictionary/presentation/bloc/dictionary_bloc.dart';
import 'package:riverpod_learn/locator.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  List<DictionaryResponse> response = [];
  @override
  void initState() {
    super.initState();
    dictionaryResponse();
  }

  final dictionaryBloc = sl<DictionaryBloc>();
  @override
  Widget build(BuildContext context) {
    return  Drawer(
      child: Column(
        children: [
          DrawerHeader(
              child: Column(
            children: 
            [
              GestureDetector(
              onTap: ()async{
                await dictionaryResponse();
              },
              child: const Icon(Icons.chevron_left_outlined)),
            ],
          )),
          Column(
            children: List.generate(response.length, (index){
              return Text(response[index].word);
            }),
          )
        ],
      ),
    );
  }

  Future<List<DictionaryResponse>> dictionaryResponse() async {
    response = await dictionaryBloc.readAllDictionary();
    setState(() {});
    return response;
  }
}
