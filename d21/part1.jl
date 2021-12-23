


function main()
    pos = [4, 5]
    points = [0,0]
    p = 1
    d = 1
    n_rolls = 0
    while maximum(points) < 1000

        d_roll = sum((d + i - 1) % 100 + 1 for i in 0:2)
        pos[p] = (pos[p] + d_roll - 1) % 10 + 1
        points[p] += pos[p]

        println("Player $p rolled $d_roll new pos: $(pos[p]) | points: $(points[p])")

        d += 3
        p = (p % 2) + 1
        n_rolls += 3

    end

    println("--- The End! ---")
    println(n_rolls)
    println(minimum(points)*n_rolls)
    
end


main()
