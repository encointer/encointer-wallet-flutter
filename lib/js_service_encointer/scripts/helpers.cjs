const execSync = require('./execSync.cjs');

function findEncointerJS () {
  // overwrite `stdio: inherit`, which drops the output
  const stdout = execSync('find ~/ -name encointer-js', { stdio: null });
  console.log(`encointer-js directory: ${stdout}`);
  return stdout.toString().trim();
}

const encointerPackages = ['util', 'types', 'node-api', 'worker-api'];

exports.findEncointerJS = findEncointerJS;
exports.encointerPackages = encointerPackages;
