using PkgFactoryMCP
using Test

@testset "PkgFactoryMCP.hello" begin
    @test PkgFactoryMCP.hello() == "Hello, World!"
end
