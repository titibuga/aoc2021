
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

    new_matrix = Set()
    for c in matrix
        if c[a] < line
            push!(new_matrix, c)
        else
            c[a] = line - (c[a] - line)
            push!(new_matrix, c)
        end
    end

    println(length(new_matrix))

  
    
end

main()
