'use strict';

import NodeRSA from 'node-rsa';
import rsa from '../../src/utils/rsa';

const fs = require('fs');

function writeFile (path, buffer) {
  fs.writeFile(path, buffer, function (err) {
    if (err) {
      return console.log(err);
    }
  });
}

const privKeyFile = 'priv';
const pubKeyFile = 'pub';
const cypherFile = 'cypher';

function writePrivKeyToFile (buffer) {
  writeFile(privKeyFile, buffer);
}

function writePubKeyToFile (buffer) {
  writeFile(pubKeyFile, buffer);
}

function writeCypherTextToFile (buffer) {
  writeFile(cypherFile, buffer);
}

function readPubKey () {
  return fs.readFileSync(pubKeyFile);
}

function nodeRsaPubKeyFromFile () {
  const pemKey = readPubKey();
  const key = new NodeRSA(pemKey, 'public');
  rsa.setKeyOpts(key);
  return key;
}

export default {
  readPubKey,
  nodeRsaPubKeyFromFile,
  writeCypherTextToFile,
  writePrivKeyToFile,
  writePubKeyToFile
};
