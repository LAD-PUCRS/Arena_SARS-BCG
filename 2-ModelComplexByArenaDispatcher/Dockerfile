from kavrakilab/hla-arena:latest
RUN mkdir /imunocovid
RUN rm -rf /var/lib/apt/lists/*
COPY ../in_data /imunocovid/in_data
COPY Model-pepHLA-APE_Gen-LAD.py /imunocovid/
WORKDIR /imunocovid
ENTRYPOINT ["python3","Model-pepHLA-APE_Gen-LAD.py"]
# /imunocovid/out_data
