const IPFS = require('ipfs-core')


export async function testIpfs () {
  const node = await IPFS.create();
  const version = await node.version();
  //const { cid } = await ipfs.add('Hello world');
  //console.info(cid);
  return {
  version
    //cid // QmXXY5ZxbtuYj6DnfApLiGstzPN7fvSyigrRee3hDWPCaf
  };
}


export default {
  testIpfs
};

