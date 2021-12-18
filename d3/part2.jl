
function getMostCommonVec(bin_l)
    vec = nothing 
    for l in bin_l
        line_vec = [ (a * 2 -1) for a in l]
        
        if vec === nothing
            vec = zeros(length(line_vec))
        end
        
        vec += line_vec
    end

    most_common_vec = vec .>= 0
    #println(most_common_vec[1])
    return most_common_vec
    # gamma_vec = vec .< 0
    # n = length(vec)
    # eps_val = sum(epsilon_vec[i]*(2^(n - i)) for i in 1:n)
    # gamma_val = sum(gamma_vec[i]*(2^(n - i)) for i in 1:n)
    # println(eps_val)
    # println(gamma_val)
    # println(eps_val*gamma_val)

end


function main()
    bin_l = []
    for l in eachline("input.txt")
        push!(bin_l, [parse(Int64, i) for i in l])
    end

    n = length(bin_l[1])
    o2_candidates = bin_l
    co2_candidates = copy(bin_l)
    for i in 1:n
        if length(o2_candidates) > 1
            #println(o2_candidates)
            #println("=====")
            o2_f_vec = getMostCommonVec(o2_candidates)
            o2_candidates = [c for c in o2_candidates if c[i] == o2_f_vec[i]]
        end

        if length(co2_candidates)  > 1
            co2_f_vec = [(a + 1)%2 for a in getMostCommonVec(co2_candidates)]
            co2_candidates = [c for c in co2_candidates if c[i] == co2_f_vec[i]]
        end
    end
    println(o2_candidates)
    println(co2_candidates)
    o2_b = o2_candidates[1]
    co2_b = co2_candidates[1]
    n = length(o2_b)
    o2_val = sum(o2_b[i]*(2^(n - i)) for i in 1:n)
    co2_val = sum(co2_b[i]*(2^(n - i)) for i in 1:n)
    println(o2_val*co2_val)
end

main()
