import 'package:flutter/material.dart';
import 'package:flutter_rpg/models/character.dart';
import 'package:flutter_rpg/models/skill.dart';
import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:flutter_rpg/theme.dart';

class SkillList extends StatefulWidget {
  const SkillList(this.character, {super.key});

  final Character character;

  @override
  State<SkillList> createState() => __SkillListState();
}

class __SkillListState extends State<SkillList> {
  late List<Skill> availableSkill;
  late Skill selectedSkills;

  @override
  void initState() {
    availableSkill = allSkills.where((skill) {
      return skill.vocation == widget.character.vocation;
    }).toList();

    if (widget.character.skills.isEmpty) {
      selectedSkills = availableSkill[0];
    }

    if (widget.character.skills.isNotEmpty) {
      selectedSkills = widget.character.skills.first;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        color: AppColors.secondaryColor.withOpacity(0.5),
        child: Column(
          children: [
            const StyledHeading('choose an active skill'),
            const StyledText('Skills are Unique to your vocation.'),
            const SizedBox(height: 20),
            Row(
              children: availableSkill.map((e) {
                return Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(2),
                  color:
                      e == selectedSkills ? Colors.yellow : Colors.transparent,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.character.updateSkill(e);
                        selectedSkills = e;
                      });
                    },
                    child: Image.asset(
                      'assets/img/skills/${e.image}',
                      width: 70,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            StyledHeading(selectedSkills.name),
          ],
        ),
      ),
    );
  }
}
