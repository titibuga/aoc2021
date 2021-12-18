vec = Int64[]
for l in eachline("input.txt")
    push!(vec, parse(Int64,l))
end

newvec = []
for i in 1:(length(vec)-2)
    push!(newvec, sum(vec[i:i+2]))
end
vec1 = vcat([newvec[1]], newvec[1:length(newvec)-1])
print(sum(newvec - vec1 .> 0))