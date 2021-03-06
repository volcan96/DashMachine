FROM arm32v7/python:3.8-slim

RUN apt-get update -q \
  && apt-get install -qy apt-utils\
#  && apt-get build-dep pillow\
  && apt-get install -qy inetutils-ping  python-pil python3 python3-pip python python-pip curl pypy python3-dev libffi-dev gcc build-essential python-setuptools zlib1g-dev libjpeg-dev libtiff-dev libpng-dev libz-dev libfreetype6-dev liblcms2-dev libwebp-dev tcl-dev libimagequant-dev libraqm-dev \
  && rm -rf /var/lib/apt/lists/* 

COPY [ "requirements.txt", "/dashmachine/" ]

WORKDIR /dashmachine

RUN python3 -m pip install --upgrade pip
RUN easy_install Pillow
RUN python3 -m pip install --no-cache-dir --progress-bar off -r requirements.txt

COPY [ ".", "/dashmachine/" ]

ENV PRODUCTION=true
EXPOSE 5000
VOLUME /dashmachine/dashmachine/user_data
CMD [ "gunicorn", "--bind", "0.0.0.0:5000", "wsgi:app" ]
