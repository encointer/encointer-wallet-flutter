const IPFS = require('ipfs-core')

export async function testIpfs () {


  const { urlSource } = IPFS;
  const ipfs = await IPFS.create();

  const file = await ipfs.add(urlSource('https://ipfs.io/images/ipfs-logo.svg'));
  console.log(file)
  return {
    node
  };
}


export default {
  testIpfs
};

