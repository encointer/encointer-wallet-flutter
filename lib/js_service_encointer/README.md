# JS Service Encointer

Javascript part that uses the [polkadot-js/api](https://polkadot.js.org/docs/api/) to connect to encointer nodes.

## How it works
The [index.js](src/index.js) is the main entry point of this library, which is launched in a hidden webView in the
Flutter application. Upon start up of the webView, a platform channel is opened, which allows dart to communicate with 
JS in the webView.

In the [settings.js](src/service/settings.js) we initialize the window fields, e.g. `window.chain`, this will make the chain
module available as top-level entrypoint from dart. All the module functions exported in the `export default` section of the JS-file can be called from the dart side.

### Example getter
JS-part

```js

export async function getBootstrappers (cid) {
  // all the types passed from dart to JS are just a json map. 
  // It is good practive to first create a type in with the
  // input value.
  const cidT = api.createType('CommunityIdentifier', cid);

  // The polkadot-js/api automatically creates getters based on the encointer-node metadata, and make it queryable 
  // like: api.query.<module-name>.<storage-name>()
  // This example queries a map because the storage is declared as such, thus the function takes one argument.
  // See rust declaration: https://github.com/encointer/pallets/blob/3fc6c4fcef549d32e0ed7beb73ac940b43b25af3/communities/src/lib.rs#L395
  return await api.query.encointerCommunities.bootstrappers(cidT);
}
```

Dart part
```dart
// parse the dynamic type into a List<String>
final bootstrappers =
        await jsApi.evalJavascript('encointer.getBootstrappers($cid)').then((bs) => List<String>.from(bs as Iterable));
```

### Caveats
* Always double check how you are passing the values from dart to JS. As JS does simply parse strings, many things can go wrong.
* JS does not know types, but polkadot-js/api helps us with `api.createType` for complex types. Trying to transform a function arg into a type will uncover errors early.
* The whole setup is unfortunately a bit brittle. Changing the dependencies, or build-process might lead to the webView not being able to understand the output binary. Always check after changes that the App still works correctly, and check in the logs for `undefined` messages.
* After rebuilding the JS part, you need to hot-restart the app. Hot-reload is not enough.

## Building and Testing

This contains basic information for building the js module and may be obvious to the seasoned js-/web dev.

### Babel
Babel is responsible for code transpiling. It ensures that the generated code runs on
all targeted environments. 

`@babel/preset-env` replaces the legacy `@babel-preset-es2015`. The old one transpiled
the code generically to `es2015` aka `es5`. The new `@babel/preset-env` allows to be much
more specific. It specifically includes transformations and polyfills for the targeted environments
given in the `.browserslistrc` file (or in package.json).

The currently targeted browsers can be viewed with `yarn browserslist`.

As this package only runs in the native webViews of Android and IOS, most of the architectures are excluded
in the `.browerslistrc`.

### Webpack
Webpack is a module-bundler. It often runs babel as one of its jobs. However, its main task is to create a dependency
graph of all modules and files (also `.css` and images) and bundles that all together in a single file that is 
ready to be served to the browser. It ensures that the necessary polyfills are included and only compiles code
from the modules that is in fact imported somewhere - in other words, it builds the bare minimum of the code.

### Jest
To be able to run the tests from Webstorm, we must add the following line the to the run/debug config in the node 
options.

```
--experimental-vm-modules
```

All the unit tests are run against an actual node, either against a local node, or directly against the gesell test 
network (cantillon is currently skipped). So new features can and should be tested against the actual node!
