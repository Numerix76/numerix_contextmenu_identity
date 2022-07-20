local directory = "numerix_images/contextmenu_identity"

local fileDownloaded = {}

function ContextMenuIdentity.GetImage(url, filename, callback)
    local destination = string.Explode("/", filename, true)
    local filename = destination[#destination]
    local finaldirectory = directory
    
    for k, v in pairs(destination) do
        if k != #destination then 
            finaldirectory = finaldirectory.."/"..v
        end
    end
    file.CreateDir(finaldirectory)

    if !fileDownloaded[filename] || !file.Exists(finaldirectory.."/"..filename, "DATA") then
        http.Fetch(url,
            function(data)
                file.Write(finaldirectory.."/"..filename, data)
                fileDownloaded[filename] = true

                if callback then
                    callback(url, "data/"..finaldirectory.."/"..filename)
                end
            end
        )
    else
        if callback then
            callback(url, "data/"..finaldirectory.."/"..filename)
        end
    end
end