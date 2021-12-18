using DataStructures

y_max = 0
x_max = 0
M = 5

function main()
    input_f = open("input.txt", "r")
    
    matrix = Dict()
    y = 0
    global x_max = 0
    for l in eachline(input_f)
        y += 1
        global x_max = length(l)
        for x in 1:length(l)
            matrix[(x,y)] = parse(Int, l[x])
        end
    end
    global y_max = y
    

    Q = PriorityQueue{Tuple{Int,Int}, Int}()
    visited = Set()
    cost_dict = Dict()
    enqueue!(Q, (1,1), 0)
    while length(Q) > 0
        (s, v) = peek(Q)

        #println("== $s ($v)")
        dequeue!(Q)
        cost_dict[s] = v
        push!(visited, s)
        for (x,y) in adj(s, matrix)
            #println("--- ($x, $y)")
            if !((x,y) in visited)
                old_v = Inf
                if (x,y) in keys(Q)
                    old_v = Q[(x,y)]
                end
                Q[(x,y)] =  min(v + cost((x,y), matrix), old_v)
            end
        end

    end

    println(cost_dict[M*x_max, M*y_max])

end

function adj((x,y), matrix)
    candidates = [(x+1, y), (x-1, y), (x, y+1), (x, y-1)]
    return [p for p in candidates if isValid(p)]
end

function isValid((x,y))
    #println("$x, $y ---- $(M*x_max), $(M*y_max)")
    return x > 0 && x <= M*x_max && y > 0 && y <= M*y_max 
end

function cost((x,y), matrix)
    tx = ((x-1) % x_max) +1
    ty = ((y-1) % y_max) +1
    bonus = floor((x-1)/x_max) + floor((y-1)/y_max)

    return (matrix[(tx, ty)] + bonus -1 ) % 9 + 1
end



main()
