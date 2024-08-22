import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riverpod_learn/core/size.dart';
import 'package:riverpod_learn/core/space.dart';
import 'package:riverpod_learn/core/widgets/text_form_field.dart';
import 'package:riverpod_learn/features/dictionary/presentation/bloc/dictionary_bloc.dart';
import 'package:riverpod_learn/features/dictionary/presentation/providers/provider.dart';
import 'package:riverpod_learn/features/word/data/datasources/local_ds.dart';
import 'package:riverpod_learn/locator.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  final dictionaryBloc = sl<DictionaryBloc>();
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // String.fromEnvironment(name)
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(""),
        leading: IconButton(
            onPressed: () async {
              final list = await WordLocalDatasourceImpl()
                  .suggestWords(params: {"text": "fak"}, context: context);
              print(list);
            },
            icon: Icon(Icons.add)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Sizes.width(
            context,
            0.04,
          ),
        ),
        child: Column(
          children: [
            DefaultTextFormField(
              onSubmitted: (p0) {
                print(p0);
                final Map<String, dynamic> params = {
                  "text": searchController.text,
                };
                dictionaryBloc.add(SearchDictionaryEvent(params: params));
              },
              focusNode: FocusNode(),
              hint: "Search any word",
              onChanged: (value) {},
              validator: (value) {
                return null;
              },
              controller: searchController,
            ),
            Space.height(context, 0.2),
            BlocConsumer(
                bloc: dictionaryBloc,
                builder: (context, state) {
                  if (state is SearchDictionaryLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is SearchDictionaryError) {
                    return Text(state.errorMessage);
                  }
                  if (state is SearchDictionaryLoaded) {
                    final itemCount = state.dictionaryInfo[0].meanings?.length;
                    return CustomScrollView(
                      shrinkWrap: true,
                      slivers: [
                        SliverList.builder(
                            itemCount: itemCount,
                            itemBuilder: (context, index) {
                              final meanings =
                                  state.dictionaryInfo[0].meanings?[0];
                              final meaningsLength =
                                  state.dictionaryInfo[0].meanings?.length;
                              print(meaningsLength);
                              // final meanings = data.meanings?[index];
                              // final definitionsLength =
                              //     data.meanings?[index].definitions![index];
                              // // print(definitionsLength);
                              // final definition = meanings?.definitions?[index];
                              return Text(
                                  meanings?.definitions?[index].definition ??
                                      "");
                            })
                      ],
                    );

                    // Expanded(
                    //   child: ListView.builder(
                    //       itemCount: itemCount,
                    //       itemBuilder: (context, index) {
                    //         final data = state.dictionaryInfo[index];
                    //         final meaningsLength = data.meanings?.length;
                    //         print(meaningsLength);
                    //         final meanings = data.meanings?[meaningsLength!];
                    //         final definitionsLength = data
                    //             .meanings?[meaningsLength!].definitions?.length;
                    //         print(definitionsLength);
                    //         final definition =
                    //             meanings?.definitions?[definitionsLength!];
                    //         return Text("");
                    //       }),
                    // );
                  }
                  return const SizedBox();
                },
                listener: (context, state) {})
          ],
        ),
      ),
    );
  }
}
