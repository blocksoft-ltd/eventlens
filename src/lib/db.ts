import { getFirestore } from "firebase/firestore";
import {firebaseApp} from "@lib/config/firebase";

export const db = getFirestore(firebaseApp)

