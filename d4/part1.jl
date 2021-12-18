
mutable struct Board
    board::Array{Int64}
    marked::Array{Bool}
    won::Bool
    Board() = new(Array{String}(undef, 5,5), fill(false, 5,5),false)
end


function main()
    
    input_f = open("input.txt", "r")
    number_list = [parse(Int64, a) for a in split(readline(input_f), ",")]
    bingo_boards = []
    while !eof(input_f)
        board = readBingoBoard(input_f)
        #println("======")
        #println(board)
        push!(bingo_boards, board)
    end

    n_boards = length(bingo_boards)
    n_completed_boards = 0
    
    winning_b = nothing
    winning_n = nothing
    last_b = nothing
    last_n = nothing
    for num in number_list
        for b in bingo_boards
            for pos in findall(x -> x == num, b.board)
                b.marked[pos] = true
            end
            if isBingo(b) && !b.won
                b.won = true
                n_completed_boards += 1
                if winning_b === nothing
                    winning_b = b
                    winning_n = num
                end
                if n_completed_boards == n_boards
                    last_b = b
                    last_n = num
                end
            end
        end
        if (n_completed_boards == n_boards)
            break
        end
    end

    println("====== result =====")
    println(sum(winning_b.board[.!winning_b.marked])*winning_n)
    println(sum(last_b.board[.!last_b.marked])*last_n)

end

function readBingoBoard(input_f)
    _ = readline(input_f)
    board = Board()
    for i in 1:5
        line = readline(input_f)
        #println(split(line))
        board.board[i,:] = [parse(Int64,a) for a in split(line)]
    end
    return board
end

function isBingo(board::Board)
    col_complete = any([all(board.marked[i,:]) for i in 1:5])
    row_complete = any([all(board.marked[:,i]) for i in 1:5])
    return col_complete || row_complete
end

main()
