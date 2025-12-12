## Firebase Storage Rules Configuration

The photo upload feature requires proper Firebase Storage security rules to allow authenticated users to upload their profile photos.

### Storage Structure

Files are uploaded to: `profile_photos/{userId}/{filename}`

For example: `profile_photos/user_12345/profile_1700000000.jpg`

### Required Firebase Storage Rules

Add these rules to your Firebase Storage (Console → Storage → Rules):

```
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    // Allow authenticated users to upload and read their profile photos
    match /profile_photos/{userId}/{allPaths=**} {
      allow read: if request.auth != null;
      allow write: if request.auth.uid == userId;
    }

    // Allow anyone to read profile photos
    match /profile_photos/{allPaths=**} {
      allow read: if true;
    }

    // Deny all other access
    match /{allPaths=**} {
      allow read, write: if false;
    }
  }
}
```

### Setting Up Firebase Storage Rules

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project (`to-be-c44a4`)
3. Navigate to **Storage** → **Rules** tab
4. Replace the existing rules with the rules above
5. Click **Publish**

### Troubleshooting Upload Errors

If you get a "Failed to upload photo" error with "permission-denied":

1. **Verify you're logged in**: The upload requires authentication
2. **Check Firebase rules**: Make sure the rules above are published
3. **Clear app cache**: Sometimes the app cache can cause issues
4. **Check internet connection**: Ensure you have a stable connection

### Testing the Upload

1. Log in to your account
2. Go to Settings
3. Click "Add profile picture"
4. Choose "Choose from Gallery" or "Take Photo"
5. Select/take a photo
6. Wait for the upload to complete

The photo URL will be saved to Firebase Auth and displayed in the app.
