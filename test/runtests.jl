using CommunicationsSequences
using Test

@testset "CommunicationsSequences.jl -- LFSR" begin
    @test begin
        l = LFSR(lfsrtaps[8])
        collect(first(l, 10))
    end == Bool[0,0,0,0,1,0,1,1,1,1]
    @test begin
        l = LFSR(lfsrtaps[8], mapping = (-2.1, 5.4))
        collect(first(l, 10))
    end == [5.4,5.4,5.4,5.4,-2.1,5.4,-2.1,-2.1,-2.1,-2.1]
    @test_throws Exception LFSR((4,5,6))
end;

@testset "CommunicationsSequences.jl -- Barker" begin
    @test barker["3"] == (1, 1, -1)
    @test_throws Exception barker["4c"]
end;
