
function main()
    input_f = open("input.txt", "r")
    out_count = 0
    for l in eachline(input_f)
        in_str, out_str = split(l, r"\s\|\s")
        println(l)
        println(out_str)
        out_count += sum( (length(w) in [2,3,4,7]) for w in split(out_str))
    end

    println(out_count)
end

main()
