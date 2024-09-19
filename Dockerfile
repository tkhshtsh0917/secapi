FROM python:3.10-slim-bullseye

WORKDIR /app

RUN apt-get update && apt-get install --no-install-recommends -y curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN curl -sSL https://install.python-poetry.org | python -

ENV PATH /root/.local/bin:$PATH
RUN poetry config virtualenvs.create false

COPY pyproject.toml poetry.lock /app/
RUN poetry install

CMD ["sh", "-c", "set -e; cd /app/secapi && uvicorn main:app --reload --host 0.0.0.0 --port 3000"]
