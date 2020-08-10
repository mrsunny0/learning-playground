// Your web app's Firebase configuration
var firebaseConfig = {
    apiKey: "AIzaSyBD9RASRRCtjjK2bn93WhGGwgl6SBblhl0",
    authDomain: "d3-example-86934.firebaseapp.com",
    databaseURL: "https://d3-example-86934.firebaseio.com",
    projectId: "d3-example-86934",
    storageBucket: "d3-example-86934.appspot.com",
    messagingSenderId: "753152078293",
    appId: "1:753152078293:web:bb59b747773c8ac6f80d5c"
};
// Initialize Firebase
firebase.initializeApp(firebaseConfig);

// manual configuration
const db = firebase.firestore();
// db.settings({
//     timestampsInSnapshots: true
// })