FROM python:3.12-slim AS builder
WORKDIR /app
COPY pyproject.toml poetry.lock ./

RUN pip install --upgrade pip \
    && pip install poetry \
    && poetry config virtualenvs.create true \
    && poetry install --no-dev

COPY . .

FROM python:3.12-slim
WORKDIR /app
COPY --from=builder /app /app
RUN pip install poetry \
    && poetry install --no-dev \
    && poetry run pip install alembic


COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh


ENTRYPOINT ["/app/entrypoint.sh"]    