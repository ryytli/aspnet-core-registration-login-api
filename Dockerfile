FROM microsoft/dotnet:2.2-sdk AS build
WORKDIR /source

# copy csproj and restore as distinct layers
COPY *.csproj .
RUN dotnet restore

# copy everything else and build app
COPY ./ ./
RUN dotnet publish -c Release -o out


FROM microsoft/dotnet:2.2-aspnetcore-runtime AS runtime
WORKDIR /source
COPY --from=build /source/out ./
EXPOSE 4000
ENTRYPOINT ["dotnet", "WebApi.dll"]
