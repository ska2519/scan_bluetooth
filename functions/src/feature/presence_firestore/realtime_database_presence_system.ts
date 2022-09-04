// // Fetch the current user's ID from Firebase Authentication.
// import * as firebase from 'firebase-admin';


// const firestore = firebase.firestore;
// const realtimeDb = firebase.database;
// const auth = firebase.auth;


// // ...
// var userStatusFirestoreRef = firestore().doc('/status/' + uid);

// // Firestore uses a different server timestamp value, so we'll
// // create two more constants for Firestore state.
// var isOfflineForFirestore = {
//     state: 'offline',
//     last_changed: firestore.FieldValue.serverTimestamp(),
// };

// var isOnlineForFirestore = {
//     state: 'online',
//     last_changed: firestore.FieldValue.serverTimestamp(),
// };

// realtimeDb().ref('.info/connected').on('value', function(snapshot) {
//     if (snapshot.val() == false) {
//         // Instead of simply returning, we'll also set Firestore's state
//         // to 'offline'. This ensures that our Firestore cache is aware
//         // of the switch to 'offline.'
//         userStatusFirestoreRef.set(isOfflineForFirestore);
//         return;
//     };

//     userStatusDatabaseRef.onDisconnect().set(isOfflineForDatabase).then(function() {
//         userStatusDatabaseRef.set(isOnlineForDatabase);

//         // We'll also add Firestore set here for when we come online.
//         userStatusFirestoreRef.set(isOnlineForFirestore);
//     });
// });
