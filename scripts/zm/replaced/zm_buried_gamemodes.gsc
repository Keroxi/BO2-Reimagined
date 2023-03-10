#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\zombies\_zm_utility;
#include maps\mp\zombies\_zm_game_module;
#include maps\mp\gametypes_zm\_zm_gametype;
#include maps\mp\zombies\_zm_buildables;
#include maps\mp\zm_buried;
#include maps\mp\zm_buried_classic;
#include maps\mp\zm_buried_turned_street;
#include maps\mp\zm_buried_grief_street;
#include maps\mp\zombies\_zm_zonemgr;
#include maps\mp\zombies\_zm_weapons;
#include maps\mp\zombies\_zm_unitrigger;
#include maps\mp\zm_buried_gamemodes;

#include scripts\zm\replaced\zm_buried_grief_street;

init()
{
    add_map_gamemode( "zclassic", maps\mp\zm_buried::zclassic_preinit, undefined, undefined );
    add_map_gamemode( "zcleansed", maps\mp\zm_buried::zcleansed_preinit, undefined, undefined );
    add_map_gamemode( "zgrief", maps\mp\zm_buried::zgrief_preinit, undefined, undefined );
    add_map_location_gamemode( "zclassic", "processing", maps\mp\zm_buried_classic::precache, maps\mp\zm_buried_classic::main );
    add_map_location_gamemode( "zcleansed", "street", maps\mp\zm_buried_turned_street::precache, maps\mp\zm_buried_turned_street::main );
    add_map_location_gamemode( "zgrief", "street", scripts\zm\replaced\zm_buried_grief_street::precache, scripts\zm\replaced\zm_buried_grief_street::main );
}

buildbuildable( buildable )
{
    player = get_players()[0];

    foreach ( stub in level.buildable_stubs )
    {
        if ( !isdefined( buildable ) || stub.equipname == buildable )
        {
            if ( isdefined( buildable ) || stub.persistent != 3 )
            {
                stub maps\mp\zombies\_zm_buildables::buildablestub_remove();

                foreach ( piece in stub.buildablezone.pieces )
                {
                    piece maps\mp\zombies\_zm_buildables::piece_unspawn();
                }

                if (is_true(level.scr_zm_ui_gametype_pro))
	            {
                    thread maps\mp\zombies\_zm_unitrigger::unregister_unitrigger( stub );

                    return;
                }

                stub maps\mp\zombies\_zm_buildables::buildablestub_finish_build( player );

                stub.model notsolid();
                stub.model show();

                return;
            }
        }
    }
}