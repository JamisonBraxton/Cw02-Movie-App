# Movie Watchlist App

CSC 4360/6360 CW-02 Flutter Movie Watchlist App.

## Features
- Scrollable HomeScreen with five movies
- DetailsScreen receives and displays a Movie object
- Local poster assets loaded with `Image.asset()`
- Navigation with `Navigator.push()` and `MaterialPageRoute`
- Session-only watchlist state
- WatchlistScreen that filters marked movies
- Polished Material 3 dark UI

## First-time setup
This source bundle contains the assignment files. If the Flutter platform folders are missing, run the included setup script on Windows PowerShell:

```powershell
powershell -ExecutionPolicy Bypass -File .\setup_flutter_project.ps1
```

Or manually run:

```bash
flutter create .
flutter pub get
flutter run
```

If `flutter create .` replaces any custom files, restore the provided `lib/`, `assets/`, and `pubspec.yaml` from the ZIP.

## Build release APK

```bash
flutter pub get
flutter build apk --release
```

The APK will be located at:

`build/app/outputs/flutter-apk/app-release.apk`

## Suggested Git commit sequence
Use real commits while you work. Do not alter commit timestamps.

```bash
git init
git add pubspec.yaml analysis_options.yaml .gitignore
git commit -m "chore: initialize Flutter movie watchlist project"

git add lib/models lib/data
git commit -m "feat: add movie model and sample movie data"

git add assets pubspec.yaml
git commit -m "feat: add local movie poster assets"

git add lib/screens/home_screen.dart lib/main.dart
git commit -m "feat: build movie list home screen"

git add lib/screens/details_screen.dart
git commit -m "feat: add movie details navigation and data passing"

git add lib/screens/watchlist_screen.dart lib/screens/details_screen.dart lib/screens/home_screen.dart
git commit -m "feat: add session watchlist feature"

git add README.md
git commit -m "docs: add setup and submission instructions"
```

Then create an empty GitHub repository and connect it:

```bash
git branch -M main
git remote add origin YOUR_GITHUB_REPOSITORY_URL
git push -u origin main
```
