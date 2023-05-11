# bobi-selldrugs
GTAV FiveM resource for drugs corner selling (QBCore, ESX &amp; standalone+ox_inventory support)

## Dependencies
* ox_lib: [https://github.com/overextended/ox_lib]
* one of:
    * qb-target: [https://github.com/qbcore-framework/qb-target]
    * ox_target: [https://github.com/overextended/ox_target]
* one of:
    * ox_inventory: [https://github.com/overextended/ox_inventory]
    * qb-inventory (qbcore): [https://github.com/qbcore-framework]
    * ESX (esx_core) **(experimental support)**: [https://github.com/esx-framework/esx-legacy]

## Installation
1. Clone git repository into your /resources folder 
`git clone git@github.com:obi23lipnik/bobi-selldrugs.git` 
2. Update bobi-methlab/config.lua
- Set your inventory resouce by updating Config.inventoryResource (options are ox_inventory and qb-inventory)
3. (optional)Add a call to client event 'bobi-selldrugs:client:StartSelling' to the action that puts you into the drug selling mode
- Alternatively you can use the /selldrugs command to turn the selling on and off
- (Experimental) You can also set `Config.sellingOnByDefault = true` inside `config.lua` which will make selling mode be on by default on player spawn
4. (optional) Update obi-selldrugs/data/drugs.lua with your chosen sellable drugs and event odds
5. Update your server.cfg to ensure/start resource bobi-selldrugs
- `ensure bobi-selldrugs` 
- Must be UNDER all dependencies
6. Restart server

## Ingame example
 (using client event 'bobi-selldrugs:client:StartSelling' added to radial menu)
[![Video with example of use](https://i.imgur.com/hScXUxi.png)](https://streamable.com/fhb407)
