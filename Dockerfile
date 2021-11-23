FROM python:3.9-slim

WORKDIR /src

ADD ./src/pyproject.toml /src

RUN set -ex \
    && apt-get update -y \
    # installing python dependencies
    && pip install --no-cache-dir --upgrade pip certifi poetry \
    && poetry install --no-dev \
    && apt-get autoremove -y \
    && apt-get clean

# Add src only in final step, so changing src doesn't rebuild the image from beginning
ADD ./src /src
