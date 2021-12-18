using DataStructures


function main()
    input_f = open("sample.txt", "r")
    
    matrix = Dict()
    y = 0
    x_max = 0
    for l in eachline(input_f)
        y += 1
        x_max = length(l)
        for x in 1:length(l)
            matrix[(x,y)] = parse(Int, l[x])
        end
    end
    y_max = y
    

    Q = PriorityQueue{Tuple{Int,Int}, Int}()
    visited = Set()
    cost_dict = Dict()
    enqueue!(Q, (1,1), 0)
    while length(Q) > 0
        (s, v) = peek(Q)

        println("== $s ($v)")
        dequeue!(Q)
        cost_dict[s] = v
        push!(visited, s)
        for (x,y) in adj(s, matrix)
            if !((x,y) in visited)
                old_v = Inf
                if (x,y) in keys(Q)
                    old_v = Q[(x,y)]
                end
                Q[(x,y)] =  min(v + matrix[(x,y)], old_v)
            end
        end

    end

    println(cost_dict[x_max, y_max])

end

function adj((x,y), matrix)
    candidates = [(x+1, y), (x-1, y), (x, y+1), (x, y-1)]
    return [p for p in candidates if p in keys(matrix)]
end



main()
