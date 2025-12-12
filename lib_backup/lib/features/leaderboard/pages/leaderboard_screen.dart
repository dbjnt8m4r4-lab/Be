import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/leaderboard_provider.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LeaderboardProvider>().loadLeaderboard();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
      ),
      body: Consumer<LeaderboardProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${provider.error}'),
                  ElevatedButton(
                    onPressed: () => provider.loadLeaderboard(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final leaderboard = provider.leaderboard;
          if (leaderboard == null || leaderboard.isEmpty) {
            return const Center(child: Text('No leaderboard data available'));
          }

          return ListView.builder(
            itemCount: leaderboard.length,
            itemBuilder: (context, index) {
              final entry = leaderboard[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Text('${entry.rank}'),
                ),
                title: Text(entry.userName),
                subtitle: Text('Score: ${entry.score}'),
                trailing: entry.isEligible 
                    ? const Icon(Icons.verified, color: Colors.green)
                    : const Icon(Icons.block, color: Colors.red),
              );
            },
          );
        },
      ),
    );
  }
}