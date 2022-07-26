FROM mcr.microsoft.com/dotnet/sdk:6.0 as build

WORKDIR /source
# Copy everything in this project and build app
COPY . ./dotnetcore-docs-hello-world/
WORKDIR /source/dotnetcore-docs-hello-world
RUN dotnet publish -c release -o /app 
# final stage/image
# We're using a tag that is explicitly a Windows container
FROM mcr.microsoft.com/dotnet/aspnet:6.0 as runtime

WORKDIR /app
COPY --from=build /app ./
# Expose port 80
# This is important in order for the Azure App Service to pick up the app
ENV PORT 80
EXPOSE 80

# Start the app
ENTRYPOINT ["dotnet", "dotnetcoresample.dll"]
