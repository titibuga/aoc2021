
mem_t = Dict()

function n_universes(pos1, pos2, p1, p2; max_p = 21)

    if max(p1,p2) >= max_p
        if p1 > p2
            return [1,0]
        else
            return [0,1]
        end
    end

    if (pos1, pos2, p1, p2) in keys(mem_t)
        return mem_t[(pos1, pos2, p1, p2)]
    end

    wins = [0,0]

    for d1 in 1:3
        for d2 in 1:3
            for d3 in 1:3
                d_roll = d1 + d2 + d3
                new_pos1 = (pos1 + d_roll -1) % 10 + 1
                new_p1 = p1 + new_pos1
                new_p2 = p2

                temp_wins = n_universes(pos2, new_pos1, new_p2, new_p1; max_p = 21)

                wins += [temp_wins[2], temp_wins[1]]

            end
        end
    end

    mem_t[(pos1, pos2, p1, p2)] = wins

    return wins



end

function main()
    pos = [4, 5]
    points = [0,0]
    println(maximum(n_universes(pos[1], pos[2], points[1], points[2])))
    
end


main()
