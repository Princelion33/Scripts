--LUA is fireee
--Secured By MoonSec V3 & Luraph Obfuscator
--Made By 50CalSpecialist#0001 or known as "frencaliber"
--LuaWare Softwares
--To Check Script Engines view the scriptsstorage repository or copy the link on the loadstring to view full engine [Obfuscated]
print("LuaWare Loader Succes")

-----------[-//LUWARE LOADER-//]-------

if game.PlaceId == 13822889 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/frencaliber/scriptsstorage/main/LumberTycoonLW",true))()
elseif game.PlaceId == 11257760806 then
    game.Players.LocalPlayer:Kick("Script is patched join discord for updates.")
setclipboard("https://discord.gg/xfmxr9cRCC")
elseif game.PlaceId == 189707 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/frencaliber/scriptsstorage/main/naturaldisaster",true))()
    elseif game.PlaceId == 1215581239 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/frencaliber/scriptsstorage/main/doomspire",true))()
    elseif game.PlaceId == 9498006165 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/frencaliber/scriptsstorage/main/tappingsimulator",true))()
    elseif game.PlaceId == 413424176 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/frencaliber/scriptsstorage/main/clonetycoon",true))()
    elseif game.PlaceId == 9938675423 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/frencaliber/scriptsstorage/main/oaklands",true))()
    elseif game.PlaceId == 8568266872 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/frencaliber/scriptsstorage/main/ktmsp",true))()
    elseif game.PlaceId == 6403373529 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/frencaliber/scriptsstorage/main/slap-battles",true))()
    elseif game.PlaceId == 566399244 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/frencaliber/scriptsstorage/main/elementalgrounds",true))()
    elseif game.PlaceId == 9772878203 then
   loadstring(game:HttpGet("https://raw.githubusercontent.com/frencaliber/scriptsstorage/main/raiseapeter",true))()
   elseif game.PlaceId == 8317588085 then
   loadstring(game:HttpGet("https://raw.githubusercontent.com/frencaliber/scriptsstorage/main/blocktycoon",true))()
   elseif game.PlaceId == 10875701453 then
   loadstring(game:HttpGet("https://raw.githubusercontent.com/frencaliber/scriptsstorage/main/edwardeatingtrain",true))()
   elseif game.PlaceId == 537413528 then
   loadstring(game:HttpGet("https://raw.githubusercontent.com/frencaliber/scriptsstorage/main/buildboattreausre",true))()
   elseif game.PlaceId == 4716045691 then
   loadstring(game:HttpGet("https://raw.githubusercontent.com/frencaliber/scriptsstorage/main/polybattles.lua",true))()
   elseif game.PlaceId == 185655149 then
   loadstring(game:HttpGet("https://raw.githubusercontent.com/frencaliber/scriptsstorage/main/bloxburg.autofarm",true))()
   elseif game.PlaceId == 3101667897 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/frencaliber/scriptsstorage/main/legendsofspeed",true))()
    elseif game.PlaceId == 2788229376 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/frencaliber/scriptsstorage/main/dahood",true))()
else
game.Players.LocalPlayer:Kick("LuaWare Doesnt Support This Game! Discord Invite has been copied")
setclipboard("https://discord.gg/xfmxr9cRCC")
end


--Discord Auto-Invite Link [ENGINE]
pcall(function()
    local JSONEncode, JSONDecode, GenerateGUID = 
  game.HttpService.JSONEncode, 
  game.HttpService.JSONDecode,
  game.HttpService.GenerateGUID
  local Request = syn and syn.request or request
  Request({
      Url = "http://127.0.0.1:6463/rpc?v=1",
      Method = "POST",
      Headers = {
          ["Content-Type"] = "application/json",
          ["Origin"] = "https://discord.com"
      },
      Body = JSONEncode(game.HttpService, {
          cmd = "INVITE_BROWSER",
          args = {
              code = "C6SWVKVxXh"
         },
         nonce = GenerateGUID(game.HttpService, false)
     }),
  })
end)


--Loader Is 80 Lines
-----------------------------LuaWare Softwares---------------------------------------------
