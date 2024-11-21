import { initializeApp } from "firebase/app";
import { getAuth, GoogleAuthProvider } from 'firebase/auth';

const firebaseConfig = {
    apiKey: "AIzaSyBpH15YH94gQY_Da66E2BbvinG939pJZNU",
    authDomain: "vue-firebase-dc0fc.firebaseapp.com",
    projectId: "vue-firebase-dc0fc",
    storageBucket: "vue-firebase-dc0fc.firebasestorage.app",
    messagingSenderId: "977228483591",
    appId: "1:977228483591:web:d2a36e9f2775dc4060eea2"
  };

  const firebase = initializeApp(firebaseConfig);
  const auth = getAuth(firebase);
  const googleProvider = new GoogleAuthProvider();
  
  export { auth, googleProvider };