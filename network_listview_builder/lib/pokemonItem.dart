import 'package:flutter/material.dart';
import 'package:network_listview_builder/pokemonModel.dart';

class PokemonItem extends StatefulWidget {
  PokemonItem({Key key, @required this.pokemon}) : super(key: key);

  final Pokemon pokemon;

  @override
  _PokemonItemState createState() => _PokemonItemState();
}

class _PokemonItemState extends State<PokemonItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(widget.pokemon.name,
                            style: TextStyle(fontSize: 18))
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text('height: ' + widget.pokemon.height.toString())
                      ],
                    ),
                    getAbilitiesRow(),
                    getStatsRows(),
                  ],
                ),
              ),
              Expanded(
                  child: Column(
                children: <Widget>[
                  Center(
                    child: Image.network(widget.pokemon.defaultImage),
                  )
                ],
              ))
            ],
          ),
        ],
      ),
    );
  }

  Widget getStatsRows() {
    List<Widget> statWidgets = <Widget>[];

    for (Map<String, dynamic> stats in widget.pokemon.stats) {
      statWidgets.add(Row(
        children: <Widget>[
          Text(stats['stat']['name'] + ": " + stats['base_stat'].toString()),
        ],
      ));
    }

    return Column(children: statWidgets);
  }

  Widget getAbilitiesRow() {
    String abilitiesString = '';

    for (Map<String, dynamic> abilities in widget.pokemon.abilities) {
      abilitiesString = abilitiesString + abilities['ability']['name'] + ', ';
    }
    abilitiesString = abilitiesString.substring(0, abilitiesString.length - 2);

    return Row(children: <Widget>[
      Expanded(child: Text('abilities: ' + abilitiesString))
    ]);
  }
}
