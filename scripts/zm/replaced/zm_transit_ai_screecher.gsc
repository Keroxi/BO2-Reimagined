#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\zombies\_zm_utility;
#include maps\mp\zombies\_zm_weapons;
#include maps\mp\zombies\_zm_ai_screecher;
#include maps\mp\zm_transit_utility;
#include maps\mp\animscripts\zm_shared;
#include maps\mp\zombies\_zm_gump;
#include maps\mp\zombies\_zm_stats;
#include maps\mp\zm_transit;
#include maps\mp\zm_transit_ai_screecher;

player_wait_land()
{
    self endon( "disconnect" );

    while ( !self isonground() )
        wait 0.1;

    if ( level.portals.size > 0 )
    {
        remove_portal = undefined;

        foreach ( portal in level.portals )
        {
            dist_sq = distance2dsquared( self.origin, portal.origin );

            if ( dist_sq < 4096 )
            {
                remove_portal = portal;
                break;
            }
        }

        if ( isdefined( remove_portal ) )
        {
            portal portal_use( self );
            wait 0.5;
        }
    }
}

portal_use( player )
{
    player playsoundtoplayer( "zmb_screecher_portal_warp_2d", player );
    self thread teleport_player( player );
    playsoundatposition( "zmb_screecher_portal_end", self.hole.origin );
}