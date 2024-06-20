import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rpg/models/character.dart';

class FirestoreService {
  static final ref = FirebaseFirestore.instance
      .collection('characters')
      .withConverter(
          fromFirestore: Character.fromFirestore,
          toFirestore: (Character c, _) => c.toFireStore());

  static Future<void> addCharacter(Character character) async {
    try {
      await ref.doc(character.id).set(character);
    } catch (e) {
      print('Error adding character: $e');
    }
  }

  static Future<QuerySnapshot<Character>> getCharacterOnce() {
    return ref.get();
  }

  static Future<void> UpdateCharacter(Character character) async {
    await ref.doc(character.id).update({
      'stats': character.statAsMap,
      'points': character.points,
      'skills': character.skills.map((s) => s.id).toList(),
      'isFav': character.isFav,
    });
  }

  static Future<void> deleteCharater(Character character) async {
    await ref.doc(character.id).delete();
  }
}
