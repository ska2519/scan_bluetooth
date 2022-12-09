import * as admin from "firebase-admin";
import {functions} from "../../index";
import {AuthRepository} from "./auth.repository";

const authRepository = new AuthRepository(admin.firestore());
// Scheduled job for expiring subscriptions in the case of missing store events
export const deleteAnonymousUsers = functions.pubsub
  .schedule('every day 00:00')
  .onRun(() => authRepository.deleteAnonymousUsers());
  
export const deleteAnonymousUsersFromRealtimeDatabase = functions.pubsub
  .topic('deleteAnonymousUsersFromRealtimeDatabase')
  .onPublish(() => authRepository.deleteAnonymousUsersFromRealtimeDatabase());
