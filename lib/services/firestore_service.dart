import 'package:cloud_firestore/cloud_firestore.dart';

class LeaderboardScore {
  const LeaderboardScore({
    required this.name,
    required this.score,
    required this.createdAt,
  });

  final String name;
  final int score;
  final DateTime? createdAt;

  factory LeaderboardScore.fromFirestore(
    QueryDocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data();

    return LeaderboardScore(
      name: (data['name'] as String?)?.trim().isNotEmpty == true
          ? (data['name'] as String).trim()
          : 'Unknown Player',
      score: (data['score'] as num?)?.toInt() ?? 0,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
    );
  }
}

class FirestoreService {
  FirestoreService({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _scoresCollection =>
      _firestore.collection('scores');

  Future<void> saveScore(
    String name,
    int score,
  ) async {
    final trimmedName = name.trim();

    if (trimmedName.isEmpty) {
      throw ArgumentError('Player name cannot be empty.');
    }

    await _scoresCollection.add({
      'name': trimmedName,
      'score': score,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<List<LeaderboardScore>> watchTopScores({
    int limit = 20,
  }) {
    return _scoresCollection
        .orderBy('score', descending: true)
        .limit(limit)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(LeaderboardScore.fromFirestore)
              .toList(growable: false),
        );
  }
}
