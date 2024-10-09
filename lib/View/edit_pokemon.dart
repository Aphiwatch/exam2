import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Model/pokemon_model.dart';

class EditPokemonPage extends StatefulWidget {
  final Pokemon pokemon;

  const EditPokemonPage({super.key, required this.pokemon});

  @override
  _EditPokemonPageState createState() => _EditPokemonPageState();
}

class _EditPokemonPageState extends State<EditPokemonPage> {
  final _formKey = GlobalKey<FormState>();
  final prevNameController = TextEditingController();
  final nextNameController = TextEditingController();

  late String name;
  late String img;
  late String height;
  late String weight;
  late String candy;
  late String egg;
  late String spawnChance;
  late String avgSpawns;
  late String spawnTime;
  List<Map<String, String>> nextEvolution = [];
  List<Map<String, String>> prevEvolution = [];

  @override
  void initState() {
    super.initState();
    // Initialize fields with existing Pokemon data
    name = widget.pokemon.name;
    img = widget.pokemon.img;
    height = widget.pokemon.height;
    weight = widget.pokemon.weight;
    candy = widget.pokemon.candy;
    egg = widget.pokemon.egg;
    spawnChance = widget.pokemon.spawnChance.toString();
    avgSpawns = widget.pokemon.avgSpawns.toString();
    spawnTime = widget.pokemon.spawnTime;
  }

  Future<void> _updatePokemon() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final response = await http.put(
        Uri.parse('http://localhost:1377/edit-pokemon-info/${widget.pokemon.id}'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'num': widget.pokemon.num,
          'name': name,
          'img': img,
          'height': height,
          'weight': weight,
          'candy': candy,
          'egg': egg,
          'multipliers': null,
          'spawn_chance': double.tryParse(spawnChance) ?? 0.0,
          'avg_spawns': int.tryParse(avgSpawns) ?? 0,
          'spawn_time': spawnTime,
          'nextEvolution': nextEvolution,
          'prevEvolution': prevEvolution,
        }),
      );

      if (response.statusCode == 200) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Completed to update Pokemon')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update Pokemon')),
        );
      }
    }
  }

  Future<void> _deletePokemon() async {
    final response = await http.delete(
      Uri.parse('http://localhost:1377/delete-pokemon/${widget.pokemon.id}'),
    );

    if (response.statusCode == 204) {
      // Send back to HomePage with true to indicate success
      Navigator.pop(context, true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pokemon deleted successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete Pokemon')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Pokemon')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: name,
                decoration: const InputDecoration(labelText: 'Name'),
                onSaved: (value) => name = value!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Pokemon name';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: img,
                decoration: const InputDecoration(labelText: 'Image URL'),
                onSaved: (value) => img = value!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter image URL';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: height,
                decoration: const InputDecoration(labelText: 'Height'),
                onSaved: (value) => height = value!,
              ),
              TextFormField(
                initialValue: weight,
                decoration: const InputDecoration(labelText: 'Weight'),
                onSaved: (value) => weight = value!,
              ),
              TextFormField(
                initialValue: candy,
                decoration: const InputDecoration(labelText: 'Candy'),
                onSaved: (value) => candy = value!,
              ),
              TextFormField(
                initialValue: egg,
                decoration: const InputDecoration(labelText: 'Egg'),
                onSaved: (value) => egg = value!,
              ),
              TextFormField(
                initialValue: spawnChance,
                decoration: const InputDecoration(labelText: 'Spawn Chance'),
                onSaved: (value) => spawnChance = value!,
              ),
              TextFormField(
                initialValue: avgSpawns,
                decoration: const InputDecoration(labelText: 'Average Spawns'),
                onSaved: (value) => avgSpawns = value!,
              ),
              TextFormField(
                initialValue: spawnTime,
                decoration: const InputDecoration(labelText: 'Spawn Time'),
                onSaved: (value) => spawnTime = value!,
              ),
              TextFormField(
                initialValue: widget.pokemon.nextEvolution.isNotEmpty ? widget.pokemon.nextEvolution.first['num'] : '',
                decoration: const InputDecoration(labelText: 'Next Evolution Num'),
                onSaved: (value) {
                  if (value != null && value.isNotEmpty) {
                    nextEvolution.add({'num': value, 'name': nextNameController.text});
                  }
                },
              ),
              TextFormField(
                controller: nextNameController..text = widget.pokemon.nextEvolution.isNotEmpty ? widget.pokemon.nextEvolution.first['name'] : '',
                decoration: const InputDecoration(labelText: 'Next Evolution Name'),
                onSaved: (value) {
                  if (value != null && value.isNotEmpty) {
                    nextEvolution.add({'name': value});
                  }
                },
              ),
              TextFormField(
                initialValue: widget.pokemon.prevEvolution.isNotEmpty ? widget.pokemon.prevEvolution.first['num'] : '',
                decoration: const InputDecoration(labelText: 'Previous Evolution Num'),
                onSaved: (value) {
                  if (value != null && value.isNotEmpty) {
                    prevEvolution.add({'num': value, 'name': prevNameController.text});
                  }
                },
              ),
              TextFormField(
                controller: prevNameController..text = widget.pokemon.prevEvolution.isNotEmpty ? widget.pokemon.prevEvolution.first['name'] : '',
                decoration: const InputDecoration(labelText: 'Previous Evolution Name'),
                onSaved: (value) {
                  if (value != null && value.isNotEmpty) {
                    prevEvolution.add({'name': value});
                  }
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updatePokemon,
                child: const Text('Update Pokemon'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Confirm Deletion'),
                        content: const Text('Are you sure you want to delete this Pokemon?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              _deletePokemon(); // Call the delete function
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: const Text('Delete'),
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Delete Pokemon', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
