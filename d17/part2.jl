

function main()
    target_area = [(150,171), (-129, -70)]
    #target_area = [(20,30), (-10, -5)]
    

    num_hits = 0

    mv_y = target_area[2][1] -1
    Mv_y = 20*abs(target_area[2][2])
    for vy in mv_y:Mv_y
        for vx in -100:300
            (my, isHit) = simulate((0,0), (vx, vy), target_area)
            if isHit
                num_hits +=1
            end
        end
    end

    println(num_hits)

    
end

function isInside(pos, target_area)
    return pos[1] >= target_area[1][1] && pos[1] <= target_area[1][2] && pos[2] >= target_area[2][1] && pos[2] <= target_area[2][2]
end

function simulate(pos, speed, target_area)
    p = [pos[1], pos[2]]
    s = [speed[1], speed[2]]
    max_y = p[2]
    while p[2] >= minimum(target_area[2])
        # println("Position: $p")
        if isInside(p, target_area)
            return (max_y, true)
        end
        p[1] += s[1]
        p[2] += s[2]
        s[1] += -sign(s[1])
        s[2] -= 1
        max_y = max(p[2], max_y)

    end
    
    return (max_y, false)
end


function hitsTarget(pos, speed, target_area)

    return simulate(pos, speed, target_area)[2]
    
end


main()