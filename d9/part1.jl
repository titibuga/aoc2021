

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

    matrix = matrix'
    ncols, nrows = size(matrix)
    println(size(matrix))
    total_risk = 0

    for i in 1:ncols
        for j in 1:nrows
            if isCritPoint(matrix, i, j)
                println("===> $i, $j, $(matrix[i,j])")
                total_risk += 1 + matrix[i,j]
            end

        end
    end

    println(total_risk)
end

function safeGet(matrix, i, j)
    ncols, nrows = size(matrix)
    if i <= 0 || i > ncols || j <= 0 || j > nrows
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
