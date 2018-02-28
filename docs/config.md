zcashd config tuning
======================

You can use environment variables to customize config ([see docker run environment options](https://docs.docker.com/engine/reference/run/#/env-environment-variables)):

        docker run -v zcashd-data:/zcash --name=zcashd-node -d \
            -p 8233:8233 \
            -p 127.0.0.1:8232:8232 \
            -e DISABLEWALLET=1 \
            -e PRINTTOCONSOLE=1 \
            -e RPCUSER=mysecretrpcuser \
            -e RPCPASSWORD=mysecretrpcpassword \
            kylemanna/zcashd

Or you can use your very own config file like that:

        docker run -v zcashd-data:/zcash --name=zcashd-node -d \
            -p 8233:8233 \
            -p 127.0.0.1:8232:8232 \
            -v /etc/myzcash.conf:/zcash/.zcash/zcash.conf \
            kylemanna/zcashd
