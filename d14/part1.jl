
function main()
    input_f = open("input.txt", "r")
    seed = readline(input_f)
    recipe = Dict()
    println("Seed: $seed")
    _ = readline(input_f)
    for l in eachline(input_f)
        (source, result) = split(l, r"\s\-\>\s")
        recipe[source] = [join([source[1], result]), join([result, source[2]])]
    end

    freq_count = Dict()
    el_count = Dict()
    for c in seed
        if !(c in keys(el_count))
            el_count[c] = 0
        end
        el_count[c] += 1
    end

    for i in 1:(length(seed)-1)
        seg = seed[i:i+1]
        if !(seg in keys(freq_count))
            freq_count[seg] = 0
        end
        freq_count[seg] += 1
    end

    #println("Recipe: $recipe")
    println(el_count)
    for i in 1:40
        freq_count = step(freq_count, recipe, el_count)
        println(el_count)
    end

    

    # for (seg, f) in freq_count
    #     println("== Seg: $seg | $f" )
    #     for c in seg
    #         if !(c in keys(el_count))
    #             el_count[c] = 0
    #         end
    #         println(" $c += $f ")
    #         el_count[c] += f
    #     end
    # end

   # println(el_count)

    vs = values(el_count)
    println(maximum(vs))
    println(minimum(vs))
    println(maximum(vs) - minimum(vs))

end

function step(freq, recipe, el_count)
    new_freq = Dict()
    for (seg, f) in freq
        c = (recipe[seg])[1][2]
        println("$seg -> $c")
        if !(c in keys(el_count))
            el_count[c] = 0
        end
        el_count[c] += f

        for ns in recipe[seg]
            if !(ns in keys(new_freq))
                new_freq[ns] = 0
            end
            new_freq[ns] += f
        end
    end
    return new_freq
end

main()
