import 'package:flutter/material.dart';
import 'package:riverpod_learn/core/extensions.dart';
import 'package:riverpod_learn/core/themes/colors.dart';

class DictionaryTestPage extends StatelessWidget {
  const DictionaryTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.ios_share, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: const MilestoneDefinition(),
    );
  }
}

class MilestoneDefinition extends StatelessWidget {
  const MilestoneDefinition({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Milestone',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                const Text(
                  '/ˈmaɪlˌstoʊn/',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(Icons.volume_up, size: 20, color: Colors.grey[600]),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: const [
                TabOption(text: 'Definition', isActive: true),
                SizedBox(width: 16),
                TabOption(text: 'Parts of Speech'),
                SizedBox(width: 16),
                TabOption(text: 'Origin'),
                SizedBox(width: 16),
                TabOption(text: 'Similar'),
              ],
            ),
            const SizedBox(height: 24),
            const DefinitionSection(
              icon: Icons.menu_book,
              title: 'Definition',
              definitions: [
                '1. (General Definition) A significant event in the development of something, especially in a person\'s career, development or process.',
                '2. A stone set up beside a road to mark the distance in miles to a particular place.',
                '3. (Business/Project Management) A key point in a project timeline, used to track progress and accomplishments or signal completion of project phases.',
                '4. A significant milestone in the product development lifecycle.'
              ],
            ),
            const SizedBox(height: 24),
            const DefinitionSection(
              icon: Icons.directions_walk,
              title: 'Example',
              definitions: [
                '1. "Starting school is a milestone in a child\'s development."',
                '2. "The old stone milestone stood beside the Roman road, worn by centuries of weather."',
                '3. "The project team celebrated reaching another milestone on time."'
              ],
            ),
            const SizedBox(height: 24),
            const PartsOfSpeechSection(),
            const SizedBox(height: 24),
            const OriginSection(),
            const SizedBox(height: 24),
            // const SimilarSection(),
            const SizedBox(height: 24),
            Center(
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Visit Wikipedia',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class TabOption extends StatelessWidget {
  final String text;
  final bool isActive;

  const TabOption({
    Key? key,
    required this.text,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isActive ? Colors.black : Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isActive ? Colors.white : Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
    );
  }
}

class DefinitionSection extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<String> definitions;

  const DefinitionSection({
    Key? key,
    required this.icon,
    required this.title,
    required this.definitions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.red[400], size: 20),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...definitions.map((definition) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                definition,
                style: const TextStyle(fontSize: 16),
              ),
            )),
      ],
    );
  }
}

class PartsOfSpeechSection extends StatelessWidget {
  const PartsOfSpeechSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.text_fields, color: Colors.red[400], size: 20),
            const SizedBox(width: 8),
            const Text(
              'Parts of Speech',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Text(
          '1. Noun (Common Usage): "refers to a significant point in time or an event that marks important development or change."',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 12),
        const Text(
          '2. (Rare) Adverbial Usage: "Occasionally used in specialized forms as \"milestone event\" or \"milestone development\" - although it is more typically an adjective."',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}

class OriginSection extends StatelessWidget {
  const OriginSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.history, color: Colors.red[400], size: 20),
            const SizedBox(width: 8),
            const Text(
              'Origin',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Text(
          '1. The word milestone comes from:\n• Middle English "mīlestōn" from Old English "mīl" (a unit of distance) + "stān" (stone).\n• Latin "milliarium", referring to a stone marker placed beside Roman roads.',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 12),
        const Text(
          '2. Originally, milestones were fixed stone markers placed alongside roads to indicate distance traveled. The metaphorical meaning, representing significant achievements or stages in development, emerged later.',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}

class SimilarSection extends StatelessWidget {
  const SimilarSection({
    super.key,
    required this.similarWords,
  });
  final List<SimilarWord> similarWords;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.compare_arrows, color: Colors.red[400], size: 20),
            const SizedBox(width: 8),
            const Text(
              'Similar',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: similarWords,
        ),
      ],
    );
  }
}

class SimilarWord extends StatelessWidget {
  final String text;

  const SimilarWord({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: context.themeData.brightness == Brightness.dark
            ? DictionaryColors.secondary200
            : DictionaryColors.secondary50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          color: context.themeData.brightness == Brightness.dark
              ? DictionaryColors.primary50
              : DictionaryColors.primary400,
        ),
      ),
    );
  }
}
