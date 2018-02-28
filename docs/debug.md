# Debugging

## Things to Check

* RAM utilization -- zcashd is very hungry and typically needs in excess of 1GB.  A swap file might be necessary.
* Disk utilization -- The zcash blockchain will continue growing and growing and growing.  Then it will grow some more.  At the time of writing, 40GB+ is necessary.

## Viewing zcashd Logs

    docker logs zcashd-node


## Running Bash in Docker Container

*Note:* This container will be run in the same way as the zcashd node, but will not connect to already running containers or processes.

    docker run -v zcashd-data:/zcash --rm -it kylemanna/zcashd bash -l

You can also attach bash into running container to debug running zcashd

    docker exec -it zcashd-node bash -l
