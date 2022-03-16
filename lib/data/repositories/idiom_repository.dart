import 'package:cloud_firestore/cloud_firestore.dart';

class IdiomRepository {
  // Top-level collection called 'idioms' is created and stored in _collection variable
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('idioms');

  // This method is to get a stream of snapshots and listens for updates automatically.
  Stream<QuerySnapshot> getStream() {
    return _collection.orderBy('phrase', descending: false).snapshots();
  }
}
