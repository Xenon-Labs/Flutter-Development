import 'package:flutter/material.dart';
import 'package:network_listview_builder/pokemonModel.dart';

class PokemonItem extends StatelessWidget {
  PokemonItem({Key key, @required this.pokemon}) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Row(children: <Widget>[
        Flexible(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                getPokemonName(),
                getPokemonHeight(),
                getAbilitiesRow(),
                getStatsRows()
              ]),
        ),
        Column(children: <Widget>[
          Center(
            child: Image.network(pokemon.defaultImage),
          )
        ]),
      ]),
    );
  }

  Widget getPokemonName() {
    return Row(
      children: <Widget>[
        Text(pokemon.name, style: TextStyle(fontSize: 18)),
      ],
    );
  }

  Widget getPokemonHeight() {
    return Row(
      children: <Widget>[
        Text('height: ' + pokemon.height.toString()),
      ],
    );
  }

  Widget getStatsRows() {
    List<Widget> statWidgets = <Widget>[];

    for (Map<String, dynamic> stats in pokemon.stats) {
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

    for (Map<String, dynamic> abilities in pokemon.abilities) {
      abilitiesString = abilitiesString + abilities['ability']['name'] + ', ';
    }
    abilitiesString = abilitiesString.substring(0, abilitiesString.length - 2);

    return Row(children: <Widget>[
      Expanded(child: Text('abilities: ' + abilitiesString))
    ]);
  }
}
