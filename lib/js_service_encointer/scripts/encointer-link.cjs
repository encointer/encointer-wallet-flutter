#!/usr/bin/env node
// Copyright 2017-2021 @encointer authors & contributors
// SPDX-License-Identifier: Apache-2.0

const { execSync } = require('child_process');
const { findEncointerJS, encointerPackages } = require('./helpers.cjs');

console.log('$ encointer-link', process.argv.slice(2).join(' '));

async function main () {
  const dir = findEncointerJS() + '/packages/';

  for (const p of encointerPackages) {
    console.log(`...creating up link for ${p}`);
    const path = dir + p + '/build/';
    execSync('yarn link', { cwd: path });

    const e = '@encointer/' + p;
    console.log(`...linking ${e}`);
    execSync(`yarn link ${e}`);
  }
}

main().catch((error) => {
  console.error(error);
  process.exit(-1);
});
