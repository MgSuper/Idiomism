import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:idiomism/data/model/idiom.dart';
import 'package:idiomism/data/repositories/idiom_repository.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final IdiomRepository repository = IdiomRepository();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Learn'),
        centerTitle: false,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: repository.getStream(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const LinearProgressIndicator();
            return _buildList(context, snapshot.data?.docs ?? []);
          }),
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot>? snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot!.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot) {
    final idiom = Idiom.fromSnapshot(snapshot);
    return Text(idiom.phrase!);
  }
}
