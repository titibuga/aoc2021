
function main()
    input_f = open("input.txt", "r")
    matrix = Dict()
    y = 1
    x_max = 0
    for l in eachline(input_f)
        x_max = length(l)
        for x in 1:length(l)
            matrix[(x,y)] = parse(Int64, l[x])
        end
        y += 1
    end
    y_max = y -1
    printMatrix(matrix, x_max, y_max)
    n_oct = length(matrix)

    s = 0
    step_n = 0
    while s != n_oct
        step_n += 1
        s = step(matrix)
        printMatrix(matrix, x_max, y_max)
    end
    println(step_n)
end

function printMatrix(matrix, max_x, max_y)
    println("-------------------")
    for y in 1:max_y
        for x in 1:max_x
            print(matrix[x,y])
        end
        println("")
    end
    println("-------------------")
end

function adj(p)
    (x,y) = p
    return [(x + 1, y), (x - 1, y), (x, y + 1), (x, y - 1), (x +1 , y +1), (x +1, y -1), (x -1, y -1), (x +1, y -1), (x -1, y+1)]
end

function step(matrix)
    has_fired = Set()
    to_be_fired = Set()
    entries = keys(matrix)
    for k in keys(matrix)
        if k in entries
            #println("====== $k")
            matrix[k] += 1
            if matrix[k] > 9
                push!(to_be_fired, k)
            end
        end
    end

    while length(to_be_fired) > 0
        temp_to_be_fired = Set()
        union!(has_fired, to_be_fired)
        for p in to_be_fired
            #println("===== FIRING: $p")

            for p in setdiff(adj(p), has_fired)
                if p in entries
                    #println("- $p ")
                    matrix[p] += 1
                    if matrix[p] > 9
                        push!(temp_to_be_fired, p)
                    end
                end

            end

            matrix[p] = 0
            #println("== $p")
        end

        to_be_fired = temp_to_be_fired
    end

    return length(has_fired)
end



main()
