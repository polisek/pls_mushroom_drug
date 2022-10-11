--  proměné
local npcs
local cam 



-- Eventy
RegisterNetEvent("pls_houbicky:client:uselysohlavky")
AddEventHandler("pls_houbicky:client:uselysohlavky", function ()
    exports['qbr-core']:Progressbar("use_bread","Eating toxic mushroom", 3000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "",
		anim = "",
		flags = 1,
    }, {}, {}, function() -- Done
        ClearPedTasks(PlayerPedId())
        ClearPedSecondaryTask(PlayerPedId())
        exports["pls_notify"]:CustomNotification({
            type = "success",
            title="Toxic mushroom", 
            text="Now the dance begins...",
            timeout=10000,
            class = "redmstyle3",
            showicon = true,
            stype = 3,
        })
        AnimpostfxStop("MP_MoonshineToxic") 
        AnimpostfxStop("MP_MatchEndPulse") 
        Citizen.InvokeNative(0x406CCF555B04FAD3,PlayerPedId(),false,0.0)
        --
        Citizen.InvokeNative(0x406CCF555B04FAD3,PlayerPedId(),true,1.0)
        Wait(2000)
        exports["pls_notify"]:CustomNotification({
            type = "success",
            title="Nothing?", 
            text="I expected more...",
            timeout=10000,
            class = "redmstyle3",
            showicon = true,
            stype = 3,
        })
        Wait(5000)
        PlaySoundFrontend("Core_Fill_Up", "Consumption_Sounds", true, 0)
        AnimpostfxPlay("MP_MoonshineToxic") 
        AnimpostfxPlay("MP_MatchEndPulse")
        AnimpostfxPlay("PhotoMode_FilterGame08")

		
        Citizen.InvokeNative(0x406CCF555B04FAD3,PlayerPedId(),false,0.0)
        startDrugAnimals()
        Wait(10000)
        stopDrugAnimals()
        Wait(20000)
		AnimpostfxStop("MP_MoonshineToxic") 
        AnimpostfxStop("MP_MatchEndPulse")
        AnimpostfxStop("PhotoMode_FilterGame08")  
    
    end, function() 
        ClearPedTasks(PlayerPedId()) 
        ClearPedSecondaryTask(PlayerPedId())
        stopDrugAnimals()
    end)
end)



function startDrugAnimals()

    local pedModel = GetHashKey("a_c_eagle_01")
    while not HasModelLoaded(pedModel) do
        modelrequest(pedModel)
        Wait(500)
    end
    local player = PlayerPedId()
    local offset = GetOffsetFromEntityInWorldCoords(player,0.0,5.0,0.0)
    local a, groundZ = GetGroundZAndNormalFor_3dCoord( offset.x, offset.y, offset.z + 10 )
    while not groundZ do
        Wait(100)
    end
    npcs = CreatePed(pedModel,offset.x,offset.y,groundZ,180.0,true,false)
    while not DoesEntityExist(npcs) do
        Wait(300)
    end
    Citizen.InvokeNative(0x283978A15512B2FE, npcs, true) --Mandatory
    TaskPedSlideToCoord(npc,offset.x,offset.y,groundZ+10)

    SetCamActive(cam, false)
    DestroyCam(cam, true)
    RenderScriptCams(false, false, 1, true, true)


    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA")
    SetCamCoord(cam, offset.x,offset.y,groundZ+10)
    SetCamRot(cam, -20.0, 0.0, 180.0 )
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 1, true, true)   
    AttachCamToEntity(cam,npcs,0.0,0.0,10.0)
    PointCamAtCoord(cam, offset.x,offset.y,groundZ) 


end



function stopDrugAnimals()
    DeleteEntity(npcs)
    SetTimecycleModifier('default')
    SetCamActive(cam, false)
    DestroyCam(cam, true)
    RenderScriptCams(false, false, 1, true, true)
end
