import 'package:flutter/material.dart';
import 'package:flutter_rpg/models/character.dart';
import 'package:flutter_rpg/screens/profile/heart.dart';
import 'package:flutter_rpg/screens/profile/skill_list.dart';
import 'package:flutter_rpg/screens/profile/stats_table.dart';
import 'package:flutter_rpg/services/character_store.dart';
import 'package:flutter_rpg/shared/styled_button.dart';
import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:flutter_rpg/theme.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({super.key, required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StyledTitle(character.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  color: AppColors.secondaryColor.withOpacity(0.3),
                  child: Row(
                    children: [
                      Hero(
                        tag: character.id.toString(),
                        child: Image.asset(
                          'assets/img/vocations/${character.vocation.image}',
                          width: 140,
                          height: 140,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            StyledHeading(character.vocation.title),
                            StyledText(character.vocation.description),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    top: 10, right: 10, child: Heart(character: character)),
              ],
            ),
            const SizedBox(height: 20),
            Center(
                child: Icon(
              Icons.code,
              color: AppColors.primaryColor,
            )),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: AppColors.secondaryColor.withOpacity(0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const StyledHeading('Slogan'),
                    StyledText(character.slogan),
                    const SizedBox(height: 10),
                    const StyledHeading('weapon of choice'),
                    StyledText(character.vocation.weapon),
                    const SizedBox(height: 10),
                    const StyledHeading('unique ability'),
                    StyledText(character.vocation.ability),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  StatsTable(character),
                  SkillList(character),
                ],
              ),
            ),
            StyledButton(
                onPressed: () {
                  Provider.of<CharacterStore>(context, listen: false)
                      .savedCharacter(character);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const StyledHeading('Character was saved.'),
                    showCloseIcon: true,
                    duration: const Duration(seconds: 2),
                    backgroundColor: AppColors.secondaryColor,
                  ));
                },
                child: const StyledHeading("save character")),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
