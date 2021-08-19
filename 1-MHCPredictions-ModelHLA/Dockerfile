from kavrakilab/hla-arena:latest
RUN mkdir /imunocovid
RUN rm -rf /var/lib/apt/lists/*

## MODELER
## TimeZone
## nano

COPY ./ /imunocovid
WORKDIR /imunocovid/1-MHCPredictions-ModelHLA
ENTRYPOINT ["/bin/bash","run.sh"]
# /imunocovid/out_data
