vec = Int64[]
for l in eachline("sample.txt")
    push!(vec, parse(Int64,l))
end
vec1 = vcat([vec[1]], vec[1:length(vec)-1])
print(sum(vec - vec1 .> 0))