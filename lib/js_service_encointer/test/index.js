import {ApiPromise} from '@polkadot/api'
import {WsProvider} from '@polkadot/rpc-provider'
import {CustomTypes} from "../src/config/types"
import {fetchCurrentPhase} from "../src/service/encointer";


async function connect(endpoint) {
    return new Promise(async (resolve, reject) => {
        const provider = new WsProvider(endpoint);
        try {
            const api = await ApiPromise.create({
                provider,
                types: CustomTypes
            });
            console.log(`${endpoint} wss connected success`);
            resolve(endpoint);

            let phase = await fetchCurrentPhase(api)
            console.log(`Phase: ${phase.phase}`);


        } catch (err) {
            console.log(`Connect ${endpoint} failed: ${err}`);
            provider.disconnect();
            resolve(null);
        }
    });
}

connect("wss://gesell.encointer.org")
