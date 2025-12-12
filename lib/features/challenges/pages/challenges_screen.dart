import 'package:flutter/material.dart';
import '../../../services/challenge_service.dart';
import '../../../data/models/challenge_model.dart';
import '../widgets/challenge_card.dart';

class ChallengesScreen extends StatefulWidget {
  const ChallengesScreen({super.key});

  @override
  State<ChallengesScreen> createState() => _ChallengesScreenState();
}

class _ChallengesScreenState extends State<ChallengesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ChallengeService _challengeService = ChallengeService();
  List<Challenge> _dailyChallenges = [];
  List<Challenge> _weeklyChallenges = [];
  List<Challenge> _morningChallenges = [];
  List<Challenge> _eveningChallenges = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _loadChallenges();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadChallenges() async {
    setState(() => _isLoading = true);
    
    _dailyChallenges = await _challengeService.getDailyChallenges();
    _weeklyChallenges = await _challengeService.getWeeklyChallenges();
    _morningChallenges = await _challengeService.getMorningChallenges();
    _eveningChallenges = await _challengeService.getEveningChallenges();
    
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Challenges'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Daily', icon: Icon(Icons.today)),
            Tab(text: 'Weekly', icon: Icon(Icons.calendar_view_week)),
            Tab(text: 'Morning', icon: Icon(Icons.wb_sunny)),
            Tab(text: 'Evening', icon: Icon(Icons.nightlight)),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadChallenges,
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildChallengeList(_dailyChallenges),
                  _buildChallengeList(_weeklyChallenges),
                  _buildChallengeList(_morningChallenges),
                  _buildChallengeList(_eveningChallenges),
                ],
              ),
            ),
    );
  }

  Widget _buildChallengeList(List<Challenge> challenges) {
    if (challenges.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.emoji_events, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              'No challenges available',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: challenges.length,
      itemBuilder: (context, index) {
        return ChallengeCard(
          challenge: challenges[index],
          onTap: () {
            // Show challenge details
          },
        );
      },
    );
  }
}





