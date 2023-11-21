export const gesellNetwork = () => {
  return {
    chain: 'wss://gesell.encointer.org',
    genesisHash: '0xa91674169884b8f312efbca48b3ad02bbf93eed0817502092c93f8f8f8a2884b',
    chosenCid: '4oyxCDvpG6oZ93VmB73rE6P6enfdDZ9PvEvw9eRoqdeM',
    customTypes: {},
    palletOverrides: {}
  };
};

export const localDevNetwork = () => {
  return {
    chain: 'ws://127.0.0.1:9944',
    worker: 'ws://127.0.0.1:2079',
    genesisHash: '0x388c446a804e24e77ae89f5bb099edb60cacc2ac7c898ce175bdaa08629c1439',
    mrenclave: '4SkU25tusVChcrUprW8X22QoEgamCgj3HKQeje7j8Z4E',
    chosenCid: '4Xgnkpg4RwXjFegLzYKgY6Y3jCSPmxyPmNvfs42Uvsuh',
    customTypes: {},
    palletOverrides: {}
  };
};
