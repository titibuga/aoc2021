using Memoize

@memoize function lanternfish(life, ndays)
    if ndays <= 0
        return 1
    end
    if life == 0
        return lanternfish(6, ndays - 1) + lanternfish(8, ndays - 1)
    else
        return lanternfish(life-1, ndays-1)
    end

end

function main()
    input_f = open("input.txt", "r")
    state = [parse(Int64,a) for a in split(readline(input_f), ",")]
    days = 256

    println(sum(lanternfish(s, days) for s in state))

end

main()
