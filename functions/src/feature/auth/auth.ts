import * as functions from 'firebase-functions';

exports.sendByeEmail = functions.auth.user().onDelete((user) => {
    // ...
});