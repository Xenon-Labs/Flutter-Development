import 'package:flutter/material.dart';
import 'package:network_listview_builder/pokemonModel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PokemonNotifier extends ValueNotifier<List<Pokemon>> {
  PokemonNotifier() : super(null);

  int _pageNumber = 1;
  bool _hasMorePokemon = true;
  int _batchesOf = 5;
  final String _apiUrl = 'https://pokeapi.co/api/v2/pokemon/';
  List<Pokemon> _listPokemons;
  bool _loading = false;

  @override
  List<Pokemon> get value => _value;
  List<Pokemon> _value;
  @override
  set value(List<Pokemon> newValue) {
    _value = newValue;
    notifyListeners();
  }

  Future<void> reload() async {
    _listPokemons = <Pokemon>[];
    _pageNumber = 1;
    await httpGetPokemon(_pageNumber);
  }

  Future<void> getMore() async {
    if (_hasMorePokemon && !_loading) {
      _loading = true;
      await httpGetPokemon(_pageNumber);
      _loading = false;
    }
  }

  Future<void> httpGetPokemon(int page) async {
    _listPokemons ??= <Pokemon>[];
    int pageNumber = page;
    while (_hasMorePokemon && (pageNumber - page) < _batchesOf) {
      http.Response res = await http.get(_apiUrl + (pageNumber).toString());
      Map<String, dynamic> jsonDecoded = json.decode(res.body);
      jsonDecoded != null
          ? _listPokemons.add(Pokemon.fromJson(jsonDecoded))
          : _hasMorePokemon = false;
      pageNumber++;
    }

    _pageNumber = pageNumber;
    value = _listPokemons;
  }
}
