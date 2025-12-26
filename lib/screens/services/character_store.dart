import 'package:flutter/material.dart';
import 'package:flutter_rpg/models/character.dart';
import 'package:flutter_rpg/screens/services/firestore_service.dart';

class CharacterStore extends ChangeNotifier {
  final List<Character> _characters = [];

  List<Character> get characters => _characters;

  // add character
  void addCharacter(Character character) {
    FirestoreService.addCharacter(character);
    _characters.add(character);
    notifyListeners();
  }

  // initially fetch characters
  void fetchCharactersOnce() async {
    if (characters.isEmpty) {
      final snapshot = await FirestoreService.getCharacterOnce();

      for (var doc in snapshot.docs) {
        _characters.add(doc.data());
      }

      notifyListeners();
    }
  }
}
