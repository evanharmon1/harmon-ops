# CHECKLIST-WIN.md
Checklist for manual steps to install a new Windows machine from scratch.

1. Install Windows from scratch

2. Docker Developer Environment on Windows
- In order to get the dockerVol shared/mounted folder working inside running docker containers, Docker settings need to share the local C drive. Sometimes a restart is required. Sometimes you need to make sure to confirm any pop up windows about sharing volumes. I think I solved some problems by putting my docker-compose and dockerVol at the C:/ root level on Windows systems. There are also some Windows features that need to be enabled like Hyper-V.
