FROM ubuntu
COPY . .
RUN mkdir -p /Data
RUN apt update
RUN apt install -y python3 pip gfortran build-essential
RUN pip install ipython numpy cftime
RUN python3 setup.py install
COPY . .
CMD ipython