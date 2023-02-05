FROM python:alpine
ENV PYTHONUNBUFFERED 1

COPY ./app /app
WORKDIR /app 
COPY ./requirements.txt requirements.txt
COPY ./requirements.dev.txt requirements.dev.txt
EXPOSE 8000
ARG DEV=false
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r requirements.txt &&\
    if $DEV; \
        then /py/bin/pip install -r requirements.dev.txt; \
    fi &&\
    adduser --disabled-password --no-create-home django-user &&\
    rm -r *.txt
ENV PATH="/py/bin:$PATH"
USER django-user