 

if Dota2AI == nil then
	_G.Dota2AI = class({})
end




------------------------------------------------------------------------------------------------------------------------------------------------------
-- Required .lua files, which just exist to help organize functions contained in our addon.  Make sure to call these beneath the mode's class creation.
------------------------------------------------------------------------------------------------------------------------------------------------------
require( "json_helpers" )
require( "hero_tools" )
require( "utility_functions" )
require( "events" )

--------------------------------------------------------------------------------
-- ACTIVATE
--------------------------------------------------------------------------------
function Activate()
    GameRules.Dota2AI = Dota2AI()
    GameRules.Dota2AI:InitGameMode()
	
end


require ("config")

--------------------------------------------------------------------------------
-- INIT
--------------------------------------------------------------------------------
function Dota2AI:InitGameMode()
	

	print( "Initializing Dota2 AI mode" )
	CustomNetTables:SetTableValue( "game_state", "base_url", { value =  Dota2AI.baseURL} )
	local GameMode = GameRules:GetGameModeEntity()
	
	GameMode:SetTowerBackdoorProtectionEnabled( true )
	--GameMode:SetFixedRespawnTime( 4 )
	GameMode:SetBotThinkingEnabled( true ) -- the ConVar is currently disabled in C++
	--GameMode:SetFogOfWarDisabled(true)
	-- Set bot mode difficulty: can try 
	--GameMode:SetCustomGameDifficulty( 1 )

	--GameRules:SetUseUniversalShopMode( false )
	--GameRules:SetPreGameTime( 1 )
	GameRules:SetCustomGameSetupTimeout( Dota2AI.ConfigUITimeout ) -- skip the custom team UI with 0, or do indefinite duration with -1
	
	
	GameMode:SetContextThink( "Dota2AI:GameThink", function() return self:GameThink() end, 0 )

	-- Events
	ListenToGameEvent( "game_rules_state_change", Dynamic_Wrap( Dota2AI, 'OnGameRulesStateChange' ), self )
	ListenToGameEvent("dota_player_pick_hero", Dynamic_Wrap(Dota2AI, 'OnHeroPicked'), self)
	ListenToGameEvent("player_chat", Dynamic_Wrap(Dota2AI, 'OnPlayerChat'), self)
	

	CustomGameEventManager:RegisterListener( "base_url_changed", function(...) return self:OnBaseURLChanged( ... ) end  )	
 end



--------------------------------------------------------------------------------
-- Main Think
--------------------------------------------------------------------------------
function Dota2AI:GameThink()
	return 0.5
end

print( "Dota2 AI  game mode loaded." )
