# DailyHub Full Starter

Customer Flutter app + Firebase Functions + Firestore rules + Codemagic workflow.

Build:
flutter pub get
flutter build apk --release

Firebase:
firebase login
firebase use YOUR_PROJECT_ID
firebase deploy --only functions,firestore

IMPORTANT:
- Firebase configuration files (google-services.json / GoogleService-Info.plist) must be generated from your Firebase project.
- Payment/recharge APIs and provider secrets are intentionally not included.
- Commission code records provider-reported commission; it does not create money by itself.
- Use a compliant payment/recharge provider and server-side webhook verification before live transactions.
