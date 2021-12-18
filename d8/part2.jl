dtn =    Dict("abcefg" => '0', 
                        "cf" => '1',
                        "acdeg" => '2',
                        "acdfg" => '3',
                        "bcdf" => '4',
                        "abdfg" => '5',
                        "abdefg" => '6',
                        "acf" => '7',
                        "abcdefg" => '8',
                        "abcdfg" => '9')
ntd =    Dict(0 => "abcefg", 
              1 => "cf",
              2 => "acdeg",
              3 => "acdfg",
              4 => "bcdf",
              5 => "abdfg",
              6 => "abdefg",
              7 => "acf",
              8 => "abcdefg",
              9 => "abcdfg")


function main()
    input_f = open("input.txt", "r")
    
    summation = 0
    for l in eachline(input_f)
        perm = "abcdefg"
        in_str, out_str = split(l, r"\s\|\s")
        in_list = [join(sort([c for c in w])) for w in split(in_str)]
        while !(perm === nothing)
            if rightPerm(perm, in_list)
                break
            else
                perm = nextPerm(perm)
            end
        end

        fixed_out_digits = join([dtn[translateDigit(perm, bd)] for bd in split(out_str)])
        #println(fixed_out_digits)
        summation += parse(Int64, fixed_out_digits)
    end

    println(summation)

    

end

function rightPerm(perm, in_list)

    digit_list = generateDigits(perm)

    return sum(w in in_list for w in digit_list) == 10

end

function translateDigit(perm, b_digit)
    right_perm = "abcdefg"
    inv_perm = Dict(perm[i] => right_perm[i] for i in 1:length(perm) )
    
    return join(sort([inv_perm[c] for c in b_digit]))
end

function generateDigits(perm)
    alph = [c for c in "abcdefg"]
    inv_alph = Dict(alph[i] => i for i in 1:length(alph) )
    digit_list = []
    for o_digit in values(ntd)
        id_list = [inv_alph[c] for c in o_digit]
        digit = join(sort([perm[i] for i in id_list]))
        push!(digit_list, digit)
    end
    return digit_list
end


function nextPerm(current_perm)
    alph = [c for c in "abcdefg"]
    inv_alph = Dict(alph[i] => i for i in 1:length(alph) )

    perm = [c for c in current_perm]
    id = length(perm)

    while id > 0
        id_c = perm[id]
        available_letters = perm[id+1:length(current_perm)]
        valid_available_letters = [c for c in available_letters if inv_alph[c] > inv_alph[id_c]]
        if length(valid_available_letters) > 0
            new_c_id = minimum(inv_alph[c] for c in valid_available_letters)
            perm[id] = alph[new_c_id]
            perm[id+1:length(perm)] = setdiff(alph, perm[1:id])
            break
        end
        id -= 1
    end

    if id == 0
        return nothing
    end

    return perm
end

# function rec_numbers(in_list, known_segs_dict, known_numbers)
#     length_count = Dict(i => Set() for i in 1:7)
#     known_segs_broken = keys(known_segs_dict)
#     known_segs_original = values(known_segs_dict)
#     n_not_rec = setdiff(Set(0:9), known_numbers)
#     for n in n_not_rec
#         w = setdiff(ntd[n], known_segs_original)
#         l = length(w)
#         if l == 0
#             continue
#         end
#         push!(length_count[l], n)
#     end

#     rec_dict = Dict()
#     for w in in_list
#         l = length(setdiff(w, known_segs_broken))
#         if l > 0 && length(length_count[l]) == 1
#             for n in length_count[l]
#                 rec_dict[n] = w
#             end
#         end
#     end

#     return rec_dict

# end

# function discover_segs(known_n_dict, known_segs_dict)
#     known_segs_broken = keys(known_segs_dict)
#     known_segs_original = values(known_segs_dict)
#     println("=====> known segs dict: $known_segs_dict")
#     println("======> KNOWN SEG B: $known_segs_broken")
#     println("======> KNOWN SEG O: $known_segs_original")
#     known_numbers = keys(known_n_dict)
#     candidate_dict = Dict(c => setdiff(Set("abcdefg"), known_segs_broken) for c in "abcdefg")
#     discovered_segs = Dict()
#     for n in known_numbers
#         for n2 in known_numbers
#             seg_diff_o = setdiff(ntd[n], ntd[n2])
#             seg_diff_o = setdiff(seg_diff_o, known_segs_original)

#             seg_diff_b = setdiff(known_n_dict[n], known_n_dict[n2])
#             seg_diff_b = setdiff(seg_diff_b, known_segs_broken)
#             for c in seg_diff_o
#                 candidate_dict[c] = candidate_dict[c] ∩ seg_diff_b
#                 if length(candidate_dict[c]) == 1
#                     b_c = pop!(candidate_dict[c])
#                     discovered_segs[b_c] = c
#                     push!(candidate_dict[c], b_c)
#                     println("===== Discovered: $b_c -> $c")
#                 end
#             end

#             seg_cap_o = ntd[n] ∩ ntd[n2]
#             seg_cap_o = setdiff(seg_diff_o, known_segs_original)

#             seg_cap_b = known_n_dict[n] ∩ known_n_dict[n2]
#             seg_cap_b = setdiff(seg_diff_b, known_segs_broken)
#             for c in seg_cap_o
#                 candidate_dict[c] = candidate_dict[c] ∩ seg_cap_b
#                 if length(candidate_dict[c]) == 1
#                     b_c = pop!(candidate_dict[c])
#                     discovered_segs[b_c] = c
#                     push!(candidate_dict[c], b_c)
#                     println("===== Discovered: $b_c -> $c")
#                 end
#             end


#         end
#     end

#     for (k,s) in candidate_dict
#         if length(s) == 2
#             c1 = pop!(s)
#             c2 = pop!(s)
#             push!(s,c1)
#             push!(s,c2)

#             for n in known_numbers
#                 if ( (c1 in known_n_dict[n]) == (k in ntd[n]) ) && ( (c2 in known_n_dict[n]) != k in ntd[n] )
#                     println("===== Discovered! $c1 -> $k")
#                     discovered_segs[c1] = k
#                 end

#                 if ( (c1 in known_n_dict[n]) != (k in ntd[n]) ) && ( (c2 in known_n_dict[n]) == k in ntd[n] )
#                     println("===== Discovered! $c2 -> $k")
#                     discovered_segs[c2] = k
#                 end

                
#             end


#         end
#     end

#     println("===> Candidate dict: $candidate_dict")

#     return discovered_segs
# end

# function decode(in_list)
#     candidate_dict = Dict(c => Set("abcdefg") for c in "abcdefg")
#     known_segs = Dict()
#     known_n_dict = Dict()
#     activity = true
#     while activity
#         activity = false
#         new_rec_numbers = rec_numbers(in_list, known_segs, keys(known_n_dict))
#         if length(new_rec_numbers) > 0
#             println("=== !!")
#             activity = true
#             in_list = [w for w in in_list if !(w in values(new_rec_numbers))]
#         end

#         for (k,w) in new_rec_numbers
#             known_n_dict[k] = w
#         end

#         new_segs_dict = discover_segs(known_n_dict, known_segs)
#         if length(new_segs_dict) > 0
#             activity = true
#         end
#         for (k,w) in new_segs_dict
#             known_segs[k] = w
#         end    

#         #known_segs = union(known_segs, new_segs_dict)
#         println("==> Known segs: $known_segs")
#         println("==> Known n: $known_n_dict")
#     end

#     return known_segs
# end

# function decode(in_list)
#     decoded_seg = Dict(c => Set("abcdefg") for c in "abcdefg")
#     rec_n = Dict()
#     cntd = copy(ntd)
#     found_original_segs = Set()
#     found_broken_segs = Set()

#     while sum(length(w) > 1 for w in values(decoded_seg)) > 0

#         # Recognize numbers
#         length_count = Dict(i => 0 for i in 1:7)
#         n_not_rec = setdiff(keys(cntd), keys(rec_n))
#         for n in n_not_rec
#             w = cntd[n]
#             l = length(w)
#             if l == 0
#                 continue
#             end
#             length_count[l] += 1
#         end
#         println("=== Count: $length_count")
#         unique_l_words = [(n,cntd[n]) for n in n_not_rec if length(cntd[n]) > 0  && length_count[length(cntd[n])] == 1 ]

#         println("==== 1 ====")
#         println(cntd)
#         println("==== 2 ====")
#         println(decoded_seg)
#         println("==== 3 ====")
#         println(n_not_rec)
       

#         for (n,w) in unique_l_words
#             # println(in_list)
#             # println(w)
#             println("===> Looking for $w")
#             println(in_list)
#             println("======")
#             println(cntd)
#             println("====")
#             println("==> $found_original_segs")
#             println("==> $found_broken_segs")
#             println(in_list)
#             idx = findfirst(x -> length(x) == length(w), in_list)
#             rec_n[n] = in_list[idx]
#         end

        

#         # find size 1 intersections and add to recognized segs

        
#         for (k,w) in rec_n
#             for (k2,w2) in rec_n
#                 sd = setdiff(w,w2)

#                 for c in setdiff(cntd[k], cntd[k2])
#                     if length(decoded_seg[c]) == 1
#                         continue
#                     end
#                     decoded_seg[c] = decoded_seg[c] ∩ sd
#                     if length(decoded_seg[c]) == 1
#                         union!(found_original_segs, decoded_seg[c])
#                         push!(found_broken_segs, c)
#                     end
#                 end

#             end
#         end

       

#         # Remove recognized segs
#         println("=== 4 ===")
#         println(found_original_segs) 
#         for (k,w) in cntd
#             cntd[k] = setdiff(w, found_original_segs)
#         end

#         for (k,w) in rec_n
#             rec_n[k] = setdiff(w, found_broken_segs)
#         end

#         in_list = [setdiff(w, found_broken_segs) for w in in_list]
        


#     end

#     # decoded_seg["a"] = setdiff(in_list[8], in_list[2])
#     # decoded_seg["c"] = 
#     # decoded_seg["e"] = setdiff(in_list[7], in_list[6])
    

# end

main()
