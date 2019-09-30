# AstbeltActivityIndicator
A high quality react native component backed by custom native iOS and Android views.

<p align="center">
<img src="https://raw.githubusercontent.com/githuboftigran/rn-astbelt-activity-indicator/master/demo_android.gif" width="200" height="200">
</p>

## Installation
1. Add

   * npm: `npm install --save rn-astbelt-activity-indicator`
   * yarn: `yarn add rn-astbelt-activity-indicator`

2. Linking

##### For older React native versions ( < 0.60 ) you need to link the library: 

   - Run `react-native link  rn-astbelt-activity-indicator`
   - If linking fails, follow the
     [manual linking steps](https://facebook.github.io/react-native/docs/linking-libraries-ios.html#manual-linking)

##### For newer React native versions ( >= 0.60 ) you need to install pods for iOS:
   - cd ios && pod install && cd ..
   - For android everything works out of the box

## Usage

```AstbeltActivityIndicator``` should have fixed width and height.

```
import AstbeltActivityIndicator from 'rn-astbelt-activity-indicator';

...

<AstbeltActivityIndicator style={{width: 100, height: 100}} />

...
```

#### Properties

| Property |      Description      | Type | Default Value |
|----------|-----------------------|------|:-------------:|
| progress | Progress segment degrees / 360 | Number<br/>Value should be in range **[0, 1]** | **0** |
| blankColor |  Color of blank dots | String<br/>(**#RRGGBB** or **#AARRGGBB**) | **#ffffff** |
| progressColor |  Color of dots in progress segment | String<br/>(**#RRGGBB** or **#AARRGGBB**) | **#ff60ad** |
