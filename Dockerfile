FROM julia:1.12.3-bookworm
WORKDIR /app
ENV JULIA_DEPOT_PATH=/opt/julia-depot
COPY Project.toml ./
COPY src ./src
COPY test/Project.toml ./test/Project.toml
RUN julia --project=. --startup-file=no -e 'using Pkg; Pkg.instantiate(); Pkg.precompile()'
COPY bin ./bin
RUN useradd --create-home --uid 10001 mcp \
    && chown -R mcp:mcp /app /opt/julia-depot
USER mcp
EXPOSE 8080
CMD ["julia", "--project=/app", "--startup-file=no", "/app/bin/pkgfactory-mcp.jl", "--transport", "http", "--host", "0.0.0.0"]
