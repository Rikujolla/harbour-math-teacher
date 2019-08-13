# harbour-math-teacher
GitHub for Math teacher


The whole software is licensed under BSD also.

Release process

There will be master branch which is a code for the releases in Jolla Harbour, OpenRepos.net and Mer OBS. The phases for the release are:

1. The new version will be devoloped in dev(version) branch
2. When translations are not changing any more the new translation file will be downloaded to www.transifex.com
3. When translations are ready check their visualization
4. Remove extra console.logs from the code
5. Finalize harbour-math-teacher.changes file
6. Test the app
7. Do Jolla Harbour tests for the rpms
8. Commit changes for the version, amend commits if changes are needed in the test process
9. Merge dev branch to the master
10. Move the source to GitHub
11. Create package from GitHub master to the Mer OBS (tar -czvf harbour-math-teacher-0.0.4.tar.bz2 ...)
12. Load the local rpms to Jolla Harbour and edit release info
13. Load the local rpms to OpenRepos and edit release info
