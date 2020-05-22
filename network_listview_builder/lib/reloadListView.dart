import 'package:flutter/material.dart';
import 'package:network_listview_builder/pokemonItem.dart';
import 'package:network_listview_builder/pokemonModel.dart';
import 'package:network_listview_builder/pokemonNotifier.dart';

class ReloadListView extends StatefulWidget {
  const ReloadListView({Key key}) : super(key: key);

  @override
  _ReloadListViewState createState() => _ReloadListViewState();
}

class _ReloadListViewState extends State<ReloadListView> {
  PokemonNotifier notifier;

  @override
  void initState() {
    super.initState();
    notifier = PokemonNotifier();
    notifier.getMore();
  }

  @override
  void dispose() {
    notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Pokemon>>(
        valueListenable: notifier,
        builder: (BuildContext context, List<Pokemon> value, Widget child) {
          return value != null
              ? RefreshIndicator(
                  onRefresh: () async {
                    return await notifier.reload();
                  },
                  child: value.isEmpty
                      ? ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: 1,
                          itemBuilder: (BuildContext context, int index) {
                            return const Center(child: Text('No Pokemon!'));
                          })
                      : NotificationListener<ScrollNotification>(
                          onNotification: (ScrollNotification scrollInfo) {
                            if (scrollInfo is ScrollEndNotification &&
                                scrollInfo.metrics.extentAfter == 0) {
                              notifier.getMore();
                              return true;
                            }
                            return false;
                          },
                          child: ListView.separated(
                              separatorBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Divider(),
                                  ),
                              padding: EdgeInsets.only(top: 20),
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: value.length,
                              cacheExtent: 5,
                              itemBuilder: (BuildContext context, int index) {
                                return PokemonItem(pokemon: value[index]);
                              }),
                        ),
                )
              : Center(child: CircularProgressIndicator());
        });
  }
}
