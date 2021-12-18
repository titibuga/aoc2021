function main()
    input_f = open("input.txt", "r")
    matrix = nothing
    for l in eachline(input_f)
        n_l = Int64[parse(Int64, n) for n in l]
        if matrix === nothing
            matrix = n_l
        else
            matrix = hcat(matrix, n_l )
        end
    end

    #matrix = matrix'
    ncols, nrows = size(matrix)
    total_risk = 0
    max_basins = [0,0,0]

    for i in 1:ncols
        for j in 1:nrows
            if true || isCritPoint(matrix, i, j)
                size = findBasin(matrix, i, j)
                push!(max_basins, size)
                
            end

        end
    end

    println(max_basins)
    println(sort(max_basins, rev=true)[1:3])
    println(prod(sort(max_basins, rev=true)[1:3]))

    return matrix
end

function basinR(matrix, i,j, visited)
    if (i,j) in visited || matrix[i,j] == 9
        return 0
    end
    push!(visited, (i,j))
    pos_list = [(i+1,j), (i-1,j), (i, j+1), (i, j-1)]
    println(matrix[i,j])

    basin_size = 1
    for (r,s) in pos_list
        if !notValid(matrix, r,s) && matrix[r,s] > matrix[i,j]
            basin_size += basinR(matrix, r,s, visited)
        end
    end
    
    return basin_size


end

function findBasin(matrix, i, j)
    visited = Set()
    println("----")
    size = basinR(matrix, i, j, visited)
    println("----")
    return size
end

function notValid(matrix, i, j)
    ncols, nrows = size(matrix)
    return i <= 0 || i > ncols || j <= 0 || j > nrows
end

function safeGet(matrix, i, j)
    if notValid(matrix, i,j)
        return Inf
    end
    return matrix[i,j]
end

function isCritPoint(matrix, i, j)
    pos_list = [(i+1,j), (i-1,j), (i, j+1), (i, j-1)]
    min_neigh = minimum(safeGet(matrix,r,s) for (r,s) in pos_list)
    return matrix[i,j] < min_neigh
end

main()
