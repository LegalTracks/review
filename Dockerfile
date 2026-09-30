FROM python:3.12-slim
WORKDIR /app
COPY bundle.zip .
RUN python -m zipfile -e bundle.zip . && rm bundle.zip && pip install --no-cache-dir -r requirements.txt && chmod -R a+rwX /app
ENV PYTHONUTF8=1 PYTHONIOENCODING=utf-8 MASARAT_APP_ENV=UAT MASARAT_DEV_AUTOLOGIN=1 MASARAT_COOKIE_CROSS_SITE=1 \
    MASARAT_KYC_DATA=/app/dev-data/data MASARAT_KYC_DB=/app/dev-data/data/dev.sqlite3 \
    MASARAT_KYC_LOGS=/app/dev-data/logs MASARAT_KYC_BACKUPS=/app/dev-data/backups
EXPOSE 10000
CMD python app.py --host 0.0.0.0 --port ${PORT:-10000}
