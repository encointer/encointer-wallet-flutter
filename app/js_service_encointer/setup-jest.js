import { TextDecoder } from 'util';
import { TextEncoder } from '@polkadot/x-textencoder';
global.TextEncoder = TextEncoder;
global.TextDecoder = TextDecoder;