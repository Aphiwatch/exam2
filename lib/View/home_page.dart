import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../View/add_pokemon.dart';
import '../View/edit_pokemon.dart';
import '../Model/pokemon_model.dart';

class HomePage extends StatefulWidget {
  final String username;

  const HomePage({super.key, required this.username});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Pokemon> _pokemons = [];
  final int _limit = 10;
  int _offset = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchPokemons();
  }

  Future<void> _fetchPokemons() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });

    final response = await http.get(Uri.parse('http://localhost:1377/pokemons?offset=$_offset'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      setState(() {
        _offset += _limit;
        _pokemons.addAll(jsonResponse.map((pokemon) => Pokemon.fromJson(pokemon)).toList());
        _isLoading = false;
      });
    } else {
      throw Exception('Failed to load pokemons');
    }
  }

  Future<void> _refreshPokemons() async {
    setState(() {
      _offset = 0;
      _isLoading = false;
      _pokemons.clear();
    });
    await _fetchPokemons(); // Fetch new data after refresh
  }

  void _navigateToEditPage(Pokemon pokemon) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditPokemonPage(pokemon: pokemon),
      ),
    );

    if (result == true) {
      // If the Pokemon was deleted, refresh the list
      await _refreshPokemons();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Welcome, ${widget.username}'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddPokemonPage()),
              );
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshPokemons,
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (!_isLoading && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
              _fetchPokemons();
            }
            return false;
          },
          child: ListView.builder(
            itemCount: _pokemons.length + 1,
            itemBuilder: (context, index) {
              if (index == _pokemons.length) {
                return _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : const SizedBox.shrink();
              }
              final pokemon = _pokemons[index];
              return ListTile(
                leading: Image.network(
                 "https://www.serebii.net/pokemongo/pokemon/152.png",
                  width: 80,
                  height: 80,
                ),
                title: Text(pokemon.name),
                subtitle: Text('Type: ${pokemon.type.join(', ')}'),
                onTap: () {
                  _navigateToEditPage(pokemon); // Call the new navigate method
                },
                trailing: Text('${pokemon.num}'),
              );
            },
          ),
        ),
      ),
    );
  }
}
