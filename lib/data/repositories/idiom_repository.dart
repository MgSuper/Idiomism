// import 'package:cloud_firestore/cloud_firestore.dart';

// class IdiomRepository {
//   final CollectionReference _collection =
//       FirebaseFirestore.instance.collection('idioms');

//   Stream<QuerySnapshot> getStream() {
//     return _collection.orderBy('phrase', descending: false).snapshots();
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:theidioms/data/model/idiom.dart';
import 'package:theidioms/data/repositories/base_idiom_repository.dart';

class IdiomRepository extends BaseIdiomRepository {
  final FirebaseFirestore _firestore;
  IdiomRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;
  @override
  Stream<List<Idiom>> getAllIdioms() {
    return _firestore.collection('idioms').orderBy('phrase', descending: false).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Idiom.fromSnapshot(doc)).toList();
    });
  }
}
