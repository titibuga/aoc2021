
function main()
    input_f = open("input.txt", "r")
    matrix = Set()
    for l in eachline(input_f)
        if l == ""
            break
        end
        println("-- $l")
        (x,y) = split(l, ",")
        x = parse(Int, x)
        y = parse(Int, y)
        push!(matrix, [x,y])
    end

    fold_vec = []

    for l in eachline(input_f)
        (axis, line) = split(pop!(split(l)), "=")
        line = parse(Int, line)

        push!(fold_vec, (axis, line))
        
    end

    (axis, line) = fold_vec[1]
    a = 2
    if axis == "x"
        a = 1
    end 

    for fi in fold_vec
        matrix = fold(matrix, fi)
    end
    
    min_x = minimum(c[1] for c in matrix)
    min_y = minimum(c[2] for c in matrix)
    max_x = maximum(c[1] for c in matrix)
    max_y = maximum(c[2] for c in matrix)

    for y in min_y:max_y
        for x in min_x:max_x
            if [x,y] in matrix
                print("■")
            else
                print(" ")
            end
        end
        println("")
    end
    
end

function fold(matrix, fi)
    (axis, line) = fi
    a = 2
    if axis == "x"
        a = 1
    end 

    new_matrix = Set()
    for c in matrix
        if c[a] < line
            push!(new_matrix, c)
        else
            c[a] = line - (c[a] - line)
            push!(new_matrix, c)
        end
    end

    return new_matrix
end

main()
