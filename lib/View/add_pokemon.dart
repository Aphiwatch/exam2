import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddPokemonPage extends StatefulWidget {
  @override
  _AddPokemonPageState createState() => _AddPokemonPageState();
}

class _AddPokemonPageState extends State<AddPokemonPage> {
  final _formKey = GlobalKey<FormState>();
  final prevNameController = TextEditingController();
  final nextNameController = TextEditingController();
  final typeController = TextEditingController(); // Controller for type input

  String num = '';
  String name = '';
  String img = '';
  String height = '';
  String weight = '';
  String candy = '';
  String egg = '';
  String spawnChance = '';
  String avgSpawns = '';
  String spawnTime = '';
  List<String> types = [];
  List<String> weaknesses = [];
  List<Map<String, String>> prevEvolution = [];
  List<Map<String, String>> nextEvolution = [];

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final response = await http.post(
        Uri.parse('http://localhost:1377/add-new-pokemon'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'num': num,
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
          'types': types,
          'weaknesses': weaknesses,
          'prev_evolution': prevEvolution,
          'next_evolution': nextEvolution,
        }),
      );

      if (response.statusCode == 201) {
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add Pokemon')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Pokemon'),
        backgroundColor: Colors.red,),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Number',
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(10.0)),
                    filled: true,
                  ),
                  onSaved: (value) => num = value!,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Pokemon number';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(10.0)),
                      filled: true,
                  ),
                  onSaved: (value) => name = value!,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Pokemon name';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Image URL',
                  border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(10.0)),
                      filled: true,),
                  onSaved: (value) => img = value!,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter image URL';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Height',
                  border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(10.0)),
                      filled: true,),
                  onSaved: (value) => height = value!,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Weight',
                  border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(10.0)),
                      filled: true,),
                  onSaved: (value) => weight = value!,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Candy',
                  border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(10.0)),
                      filled: true,),
                  onSaved: (value) => candy = value!,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Egg',
                  border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(10.0)),
                      filled: true,),
                  onSaved: (value) => egg = value!,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Spawn Chance',
                  border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(10.0)),
                      filled: true,),
                  onSaved: (value) => spawnChance = value!,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Average Spawns',
                  border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(10.0)),
                      filled: true,),
                  onSaved: (value) => avgSpawns = value!,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Spawn Time',
                  border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(10.0)),
                      filled: true,),
                  onSaved: (value) => spawnTime = value!,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Type',
                  border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(10.0)),
                      filled: true,),
                  controller: typeController, // Set the controller
                  onSaved: (value) {
                    if (value != null && value.isNotEmpty) {
                      types.add(value); // Add the type to the list
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration:
                      InputDecoration(labelText: 'Previous Evolution Num',
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(10.0)),
                      filled: true,),
                  onSaved: (value) {
                    if (value != null && value.isNotEmpty) {
                      prevEvolution
                          .add({'num': value, 'name': prevNameController.text});
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: prevNameController,
                  decoration:
                      InputDecoration(labelText: 'Previous Evolution Name',
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(10.0)),
                      filled: true,),
                  onSaved: (value) {
                    if (value != null && value.isNotEmpty) {
                      prevEvolution.add({'name': value});
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Next Evolution Num',
                  border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(10.0)),
                      filled: true,),
                  onSaved: (value) {
                    if (value != null && value.isNotEmpty) {
                      nextEvolution
                          .add({'num': value, 'name': nextNameController.text});
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: nextNameController,
                  decoration: InputDecoration(labelText: 'Next Evolution Name',
                  border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(10.0)),
                      filled: true,),
                  onSaved: (value) {
                    if (value != null && value.isNotEmpty) {
                      nextEvolution.add({'name': value});
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Add Pokemon'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
