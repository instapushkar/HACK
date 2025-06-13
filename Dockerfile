# Use .NET 8.0 SDK for building
FROM mcr.microsoft.com/dotnet/sdk:8.0-alpine AS build
WORKDIR /src
COPY ./src ./src
RUN dotnet publish src/VulnerableApi/VulnerableApi.csproj -c Release -o /app/publish

# Use .NET 8.0 runtime for the final image
FROM mcr.microsoft.com/dotnet/aspnet:8.0-alpine AS final
WORKDIR /app

# Create a non-root user
RUN adduser --disabled-password --gecos "" appuser && chown -R appuser /app
USER appuser

# Copy only the published files
COPY --from=build /app/publish .
EXPOSE 8080
ENV ASPNETCORE_URLS=http://+:8080
ENTRYPOINT ["dotnet", "VulnerableApi.dll"]
