


function main()
    input_f = open("input.txt", "r")
    on_cubes = Set()
    for l in eachline(input_f)
        status, coords = split(l)
        (xc, yc, zc) = readCoords(coords)
        if maximum(abs.(xc)) > 50 || maximum(abs.(yc)) > 50 || maximum(abs.(zc)) > 50
            continue
        end

        for x in xc[1]:xc[2]
            for y in yc[1]:yc[2]
                for z in zc[1]:zc[2]
                    if status == "on"
                        push!(on_cubes, (x,y,z))
                    else
                        delete!(on_cubes, (x,y,z))
                    end
                end
            end
        end
    end

    println(length(on_cubes))

    
end

function readCoords(coords)
    function parseC(cpair)
        _, cp = split(cpair, "=")
        return [parse(Int,n) for n in split(cp, "..")]
    end

    xc, yc, zc = [parseC(p) for p in split(coords, ",")]
end
main()
