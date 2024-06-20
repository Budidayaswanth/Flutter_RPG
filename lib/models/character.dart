import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rpg/models/skill.dart';
import 'package:flutter_rpg/models/stats.dart';
import 'package:flutter_rpg/models/vocation.dart';

class Character with Stats {
  Character(
      {required this.name,
      required this.vocation,
      required this.slogan,
      required this.id});

  final String name;
  final Set<Skill> skills = {};
  final Vocation vocation;
  final String slogan;
  final String id;
  bool _isFav = false;

  bool get isFav => _isFav;

  void toggleIsFav() {
    _isFav = !_isFav;
  }

  void updateSkill(Skill skill) {
    skills.clear();
    skills.add(skill);
  }

  Map<String, dynamic> toFireStore() {
    return {
      'name': name,
      'slogan': slogan,
      'isFav': _isFav,
      'vocation': vocation.toString(),
      'skills': skills.map((s) => s.id).toList(),
      'stats': statAsMap,
      'points': points,
    };
  }

  factory Character.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data()!;

    Character character = Character(
      name: data['name'],
      vocation:
          Vocation.values.firstWhere((v) => v.toString() == data['vocation']),
      slogan: data['slogan'],
      id: snapshot.id,
    );

    for (String id in data['skills']) {
      Skill skill = allSkills.firstWhere((element) => element.id == id);
      character.updateSkill(skill);
    }

    if (data['isFav'] == true) {
      character.toggleIsFav();
    }

    character.setStats(points: data['points'], stats: data['stats']);

    return character;
  }
}

List<Character> characters = [
  Character(
      id: '1', name: 'Klara', vocation: Vocation.wizard, slogan: 'Kapumf!'),
  Character(
      id: '2',
      name: 'Jonny',
      vocation: Vocation.junkie,
      slogan: 'Light me up...'),
  Character(
      id: '3',
      name: 'Crimson',
      vocation: Vocation.raider,
      slogan: 'Fire in the hole!'),
  Character(
      id: '4',
      name: 'Shaun',
      vocation: Vocation.yash,
      slogan: 'Alright then gang.'),
];
