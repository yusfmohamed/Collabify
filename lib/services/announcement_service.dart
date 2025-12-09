import 'package:collabify/models/announcement.dart';

// Global list to store announcements (in-memory, resets on app restart)
List<Announcement> announcements = [
  // Pre-populated data (from your original JoinScreen)
  Announcement(
    userName: "@nada",
    projectName: "Wusol",
    description: "I'm building a mobile app that connects to Spotify and uses AI to generate unique visuals based on what you're listening to. I'm planning on using a react frontend, with rust on the back.",
    language: "flutter",
    teamNum: "4",
    projectType: "mobile",
  ),
  Announcement(
    userName: "@yusf",
    projectName: "Collabify",
    description: "I'm building a web app that connects to Spotify and uses AI to generate unique visuals based on what you're listening to. I'm planning on using a react frontend, with rust on the back.",
    language: "react",
    teamNum: "2",
    projectType: "web",
  ),
  Announcement(
    userName: "@jana",
    projectName: "Study Tracking App",
    description: "I'm working on a mobile app for helping track study patterns. The goal is to have something similar to quizlet, but simpler and easier to navigate.",
    language: "kotlin",
    teamNum: "1",
    projectType: "mobile",
  ),
  Announcement(
    userName: "@maya",
    projectName: "AI Crypto Tool",
    description: "been reading about crypto prediction and ML stuff. want to make a basic tool using past prices to spot patterns.",
    language: "python",
    teamNum: "1",
    projectType: "desktop",
  ),
  Announcement(
    userName: "@gaber",
    projectName: "Open Source Animation App",
    description: "Let's make an open source animation app together! New to Github and programming so please walk me through, I am learning too so if you don't know anything too, I want to hear from everybody!",
    language: "javaScript",
    teamNum: "5",
    projectType: "web",
  ),
];