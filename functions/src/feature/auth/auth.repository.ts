import * as admin from "firebase-admin";

export class AuthRepository {
  constructor(private firestore: FirebaseFirestore.Firestore) {}

  async deleteAnonymousUsers(): Promise<void> {
    await this.deleteAnonymousUsersFromAuth();
    await this.deleteAnonymousUsersFromFirestore();
  }

  
  async deleteAnonymousUsersFromRealtimeDatabase(): Promise<void> {
    try {
      console.log(`Start deleteAllAnonymousUsersFromRealtimeDatabase`);
      const db = admin.database();
      const snapshot = await db.ref('/status').get();
    
      snapshot.forEach((user) => { 
          const isAnonymous = user.exportVal()['is_anonymous'];
          console.log(`deleteAllAnonymousUsersFromRealtimeDatabase isAnonymous: `, isAnonymous);
          const userPath = user.ref;
          if (isAnonymous) db.ref(userPath).remove();
        });
    
      console.log(`Successfully deleteAllAnonymousUsersFromRealtimeDatabase`);
    } catch (error) {
      console.log(`Error deleteAnonymousUsersFromRealtimeDatabase:`, error);
    }
  }


  async deleteAnonymousUserFromRealtimeDatabase(uid: string): Promise<void> {
    try {
      const db = admin.database();
      await db.ref(`/status/${uid}`).remove();
      console.log(`Successfully deleteAnonymousUsersFromRealtimeDatabase uid: ${uid}`);
    } catch (error) {
      console.log(`Error deleteAnonymousUsersFromRealtimeDatabase: ${error}`);
    }
  }

  async deleteAnonymousUsersFromFirestore(): Promise<void> {
    try {
      const documents = await this.firestore
          .collection("users")
          .where("isAnonymous", "==", true)
          .get();
      console.log('deleteAnonymousUsersFirestoreData documents.size: ', documents.size);
      if (!documents.size) return;

      const writeBatch = this.firestore.batch();
      documents.docs.forEach((doc) => writeBatch.delete(doc.ref));

      const result = await writeBatch.commit();
      console.log('Successfully deleteAnonymousUsersFromFirestore result: ', result);
    } catch (error) {
      console.log('Error deleteAnonymousUsersFromFirestore: ', error);
    }
  }

  deleteAnonymousUsersFromAuth = async (nextPageToken?: string) => {
    try {
    // List batch of users, 10 at a time.
      const listUsersResult = await admin.auth().listUsers(10, nextPageToken);

      listUsersResult.users.forEach(async (userRecord) => {
        console.log('userRecord.email: ', userRecord.email); 
        if (userRecord.email == null) {
          await admin.auth().deleteUser(userRecord.uid);
          console.log('Successfully deleteAnonymousUsersFromAuth uid: ', userRecord.uid); 
          await this.deleteAnonymousUserFromRealtimeDatabase(userRecord.uid);
        }
      });
        
      if (listUsersResult.pageToken) {
        console.log('deleteAnonymousUsersFromAuth pageToken: ', listUsersResult.pageToken);
        // Wait to delete each set of users to abide by Firebase timeout
        setTimeout(() => this.deleteAnonymousUsersFromAuth(listUsersResult.pageToken), 2000);
      } else {
        console.log('deleteAnonymousUsersFromAuth no more users found');
      }
    } catch (error) {
      console.log('Error deleteAnonymousUsersFromAuth:', error);
    }
  };

  deleteAllUsers = async (nextPageToken?: string) => {
    try {
    // List batch of users, 10 at a time.
      const listUsersResult = await admin.auth().listUsers(10, nextPageToken);

      listUsersResult.users.forEach(async (userRecord) => {
        await admin.auth().deleteUser(userRecord.uid);
        console.log('Successfully deleteAllUsers uid: ', userRecord.uid);
      });

      if (listUsersResult.pageToken) {
        console.log('listUsersResult pageToken: ', listUsersResult.pageToken);
        // Wait to delete each set of users to abide by Firebase timeout
        setTimeout(() => this.deleteAllUsers(listUsersResult.pageToken), 2000);
      } else {
        console.log('no more users found');
      }
    } catch (error) {
      console.log('Error deleteAllUsers:', error);
    }
  };
}
