import { bnToU8a } from '@polkadot/util';
import { stringToDegree } from '@encointer/types/index.d.ts';

/**
 * Parses a location json with fields as number strings to a `Location` object.
 *
 * There is a rust vs. JS endian issue with numbers: https://github.com/polkadot-js/api/issues/4313.
 *
 * tl;dr: If the returned location is processed:
 *  * by a node (rust), use isLe = false.
 *  * by JS, e.g. `parseDegree`, use isLe = true.
 *
 *
 * @param api
 * @param location fields as strings, e.g. '35.2313515312'
 * @param isLe
 * @returns {Location} Location with fields as fixed-point numbers
 */
export function locationFromJson (api, location, isLe = false) {
  return api.createType('Location', {
    lat: bnToU8a(stringToDegree(location.lat), 128, isLe),
    lon: bnToU8a(stringToDegree(location.lon), 128, isLe),
  });
}
