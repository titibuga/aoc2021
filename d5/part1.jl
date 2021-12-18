using LinearAlgebra

struct lineSegment
    from::Array{Int64}
    to::Array{Int64}
    lineSegment(vec::Array{Int64}) = new(vec[1:2], vec[3:4])
end

function antiI(n)
    M = fill(0, n, n)
    for i in 1:n
        M[i, n - i + 1] = 1
    end
    return M
end


function main()
    #input_f = open("sample.txt", "r") 
    lines = []
    max_x = -1
    max_y = -1
    for l in eachline("input.txt")
        coords = [parse(Int64, a) + 1 for a in split(l, r"(\s->\s)|\,")]
        push!(lines, lineSegment(coords))
        max_x = max(max_x, coords[1], coords[3])
        max_y = max(max_y, coords[2], coords[4])
    end
    board = fill(0, max_x, max_y)
    #println(lines)

    for l in lines
        x_c = sort([l.to[1], l.from[1]])
        y_c = sort([l.to[2], l.from[2]])
        x_w = abs(l.to[1] - l.from[1]) +1
        y_w = abs(l.to[2] - l.from[2]) +1
        if x_w > 1 && y_w > 1
            if (l.to[1] - l.from[1])*(l.to[2] - l.from[2]) < 0
                board[x_c[1]:x_c[2], y_c[1]:y_c[2]] += antiI(x_w)
            else
                board[x_c[1]:x_c[2], y_c[1]:y_c[2]] += Matrix{Int64}(I, x_w, y_w)
            end
        else
            board[x_c[1]:x_c[2], y_c[1]:y_c[2]] += ones(x_w, y_w)
        end
    end

    # for i in 1:max_y
    #     println(board[:,i])
    # end


    println("==== Result =====")
    println(sum(board .>= 2))
end

main()
