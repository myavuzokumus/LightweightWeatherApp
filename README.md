# WeatherApp

| Image | Description |
| --- | --- |
| ![](/assets/layout2.png) | This is my first Flutter project that I developed with Backend. Django is used in the background of this simple and easy to use Weather app. |

![](/assets/layout1.png)

### TODO:
Frontend (Flutter side):
- Some theme and data adjustment will be applied. (75%)
- Fetched days data will be fixed.
- Fetched days data will be fixed.

Backend (Django & RestAPI):
- Data will be refreshed every 15 minute from API.
- Will be added files after project completely finished. (Need some fixes to security for API)

## Installation

1. Create a new Flutter project:
```
flutter create weather_app
```

2. Clone the repository:
```
git clone https://github.com/myavuzokumus/WeatherApp.git
```

3. Create ".env" file in root directory and add your Google Maps AutoComplete Places API Key in the file:
```
PLACES_API_KEY=key
```

4. Test your changes by running the app on an emulator or a physical device:
```
flutter run
```

## Packages

- [hive](https://pub.dev/packages/hive) - Save for the user’s selected city in device’s storage.
- [lottie](https://pub.dev/packages/lottie) - To use animated icons in an app.
- [screenutil](https://pub.dev/packages/flutter_screenutil) - To make a responsive design for an app.
- [http](https://pub.dev/packages/http) - To fetch data from JSON.

## APIs

- [visualcrossing] - Weather Data
- [Google Maps AutoComplete Places]- City Data

## License

This project is licensed under the [MIT License](/LICENSE).
