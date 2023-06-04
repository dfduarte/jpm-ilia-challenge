FROM python:3.9 as base

RUN apt-get update && \
    apt-get install --yes curl netcat

RUN pip3 install --upgrade pip
RUN pip3 install virtualenv

RUN virtualenv -p python3 /appenv

ENV PATH=/appenv/bin:$PATH

# ------------------------------------------------------------------------

RUN apt-get update && \
    apt-get install --yes build-essential autoconf libtool pkg-config \
    libgflags-dev libgtest-dev clang libc++-dev automake git libpq-dev

COPY . /application

RUN pip install -r /application/requirements.txt

RUN chmod +x /application/run.sh

ENV PIP_WHEEL_DIR=/application/wheelhouse
ENV PIP_FIND_LINKS=/application/wheelhouse

CMD ["/application/run.sh"]