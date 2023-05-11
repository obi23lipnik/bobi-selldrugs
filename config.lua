Config = {}

Config.useTarget = true  -- currently no effect either way; A target resource is required
Config.sellingOnByDefault = false  -- If true(experimental), the player will be put into "selling mode" on spawn
                                   -- If false(recommended) the client event: bobi-selldrugs:client:StartSelling must be called to put player into "selling mode"

Config.inventoryResource = 'ox_inventory' -- Supported resources: 'ESX'(experimental), 'qb-inventory', 'ox_inventory'
Config.targetResource = 'qb-target' -- Supported resources: 'qb-target', 'ox_target'

Config.policeCallClientFunction = function ()
    -- EDIT THIS TO CALL YOUR POLICE SCRIPT HOOKS --
    -- This gets called when call police chance is triggered
    -- Must use only client side exports
    -- exports['ps-dispatch']:DrugSale()
    -- exports['sd-aipolice']:ApplyWantedLevel(1)
end

Config.forbiddenModels = {
    -- Human peds
    `mp_m_freemode_01`,
    `mp_f_freemode_01`,
    `csb_cop`,
    `ig_trafficwarden`,
    `s_f_y_cop_01`,
    `s_m_m_snowcop_01`,
    `s_m_y_cop_01`,
    `s_m_y_hwaycop_01`,
    `mp_m_shopkeep_01`,
    `mp_m_fibsec_01`,
    `mp_s_m_armoured_01`,
    `mp_m_securoguard_01`,
    `s_m_y_swat_01`,
    `s_m_y_sheriff_01`,
    `s_m_m_paramedic_01`,
    `s_m_m_paramedic_01`,

    -- Animal peds
    `a_c_boar`,
    `a_c_cat_01`,
    `a_c_chickenhawk`,
    `a_c_chimp`,
    `a_c_chop`,
    `a_c_cormorant`,
    `a_c_cow`,
    `a_c_coyote`,
    `a_c_crow`,
    `a_c_deer`,
    `a_c_dolphin`,
    `a_c_fish`,
    `a_c_hen`,
    `a_c_humpback`,
    `a_c_husky`,
    `a_c_killerwhale`,
    `a_c_mtlion`,
    `a_c_pig`,
    `a_c_pigeon`,
    `a_c_poodle`,
    `a_c_pug`,
    `a_c_rabbit_01`,
    `a_c_rat`,
    `a_c_retriever`,
    `a_c_rhesus`,
    `a_c_rottweiler`,
    `a_c_seagull`,
    `a_c_sharkhammer`,
    `a_c_sharktiger`,
    `a_c_shepherd`,
    `a_c_stingray`,
    `a_c_westy`,
}