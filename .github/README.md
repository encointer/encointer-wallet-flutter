## GitHub Actions Hints

### IOS
Sometimes after a Github Actions Runner update, the Xcode version is updated, which changes the available IOS runtimes.
This makes the IPad simulator creation fail because our runtime is no longer available. We can simply replace the 
runtime with one of the available runtimes printed in the `Prepare environment for IOS` stage.