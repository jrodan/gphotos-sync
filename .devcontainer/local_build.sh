# locally build a runtime container for testing
docker rmi gphotos-sync-jr:latest

# first make sure a wheel is built
(
    cd ..
    pip3 install build
    rm -r dist
    python3 -m build --wheel
)

# make the container name the same as the root folder name of this clone
container_name="gphotos-sync-jr"
echo building $container_name ...

# run the build with required build-args for a runtime build
ln -s ../dist .
docker build --build-arg BASE=python:3.10-slim -t $container_name .. --file ./Dockerfile
unlink dist
