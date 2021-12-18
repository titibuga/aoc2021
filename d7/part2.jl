using Statistics


function fuelUse(positions, x)
    arsum(n) = (n/2)*(n+1)
    return sum(arsum.(abs.(positions .- x)))
end

function main()
    input_f = open("input.txt", "r")
    positions = [parse(Int64,a) for a in split(readline(input_f), ",")]

    left = minimum(positions)
    right = maximum(positions)
    mid = Int(floor((left + right)/2))

    while left < right
        #println("===> $mid")
        x = mid
        x_l = mid-1
        x_r = mid+1
        #println("===> $(fuelUse(positions, x_l)) | $(fuelUse(positions, x)) |$(fuelUse(positions, x_r))")
        if fuelUse(positions, x_l) < fuelUse(positions, x)
            right = mid
        elseif fuelUse(positions, x_r) < fuelUse(positions, x)
            left = mid
        else
            left = right = mid
        end
        mid = Int(floor((left + right)/2))
    end

    println(mid)
    println(fuelUse(positions, mid))
end

main()
