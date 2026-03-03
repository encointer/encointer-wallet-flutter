# Releasing

## GitHub Actions Hints

### iOS

Sometimes after a Github Actions Runner update, the Xcode version is updated, which changes the available iOS runtimes.
This makes the iPad simulator creation fail because our runtime is no longer available. We can simply replace the
runtime with one of the available runtimes printed in the `Prepare environment for IOS` stage.

## App Release

### Pre-release testing

There is quite some manual testing, which we can't automate currently. Before a release, an issue should be created
based on the `Release Testing Rococo` template. It will generate an issue with a task list of the features that need to
be tested. Two things need to be inserted into the template: 1. The commit that is tested. 2. The version that should be
released after testing.

### Release flow

* VersionName should follow the semver policy.
* VersionCode should monotonically increase by 1 for every tagged build

#### GitHub Actions (Google Play Store & Apple AppStore)

GitHub Actions automatically builds and deploys on push to `beta` or when a version tag is pushed.

```shell
git checkout master
git pull
git tag v0.9.0
git push origin v0.9.0
git checkout beta
git merge v0.9.0
git push
```

#### F-droid

F-droid triggers builds based on tags. We will use a special tag format for the f-droid releases: e.g. `vx.x.x-fdroid`.

Note: We have a different release branch for f-droid, as we had to use another, less performant scanner library to meet
FOSS constraints.
