# bobi-selldrugs
GTAV FiveM resource for drugs corner selling (QBCore &amp; ox_inventory support)

## Dependencies
* ox_lib: [https://github.com/overextended/ox_lib]
* one of:
    * qb-target: [https://github.com/qbcore-framework/qb-target]
    * ox_target: [https://github.com/overextended/ox_target]
* one of:
    * ox_inventory: [https://github.com/overextended/ox_inventory]
    * qb-inventory (qbcore): [https://github.com/qbcore-framework]

## Installation
1. Clone git repository into your /resources folder 
`git clone git@github.com:obi23lipnik/bobi-selldrugs.git` 
2. Update bobi-methlab/config.lua
- Set your inventory resouce by updating Config.inventoryResource (options are ox_inventory and qb-inventory)
3. Add a call to client event 'bobi-selldrugs:client:StartSelling' to the action that puts you into the drug selling mode
4. (optional) Update obi-selldrugs/data/drugs.lua with your chosen sellable drugs and event odds
5. Update your server.cfg to ensure/start resource bobi-selldrugs
- `ensure bobi-selldrugs` 
- Must be UNDER your chosen inventory resource, dpemotes, oxlib, qb-target and ox_mysql resources 
6. Restart server

## Ingame example
Client event 'bobi-selldrugs:client:StartSelling' added to radial menu

[![Video with example of use](https://i.imgur.com/R2xgC4w.png)](https://streamable.com/vi9nvg)
