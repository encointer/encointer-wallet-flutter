import '../';
import { CustomTypes } from '../config/types';
import { useWorker } from './worker';
import { TypeRegistry } from '@polkadot/types/create/registry';

describe('worker', () => {
  let keyring;
  let registry;
  beforeAll(async () => {
    registry = new TypeRegistry();
    registry.register(CustomTypes);
    const query = {
      encointerScheduler: {
        currentPhase: jest.fn().mockImplementation(() => Promise.resolve(123))
      }
    };
    window.api = { registry, query };
    window.workerApi = useWorker('wss://substratee03.scs.ch');
  });

  describe('getters', () => {
    it('should getTotalIssuance', async () => {
      const cid = '3LjCHdiNbNLKEtwGtBf6qHGZnfKFyjLu9v3uxVgDL35C';
      const result = await window.workerApi.getTotalIssuance(cid);
      expect(result).toEqual({ phase: 123 });
    });
  });
});
