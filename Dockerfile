# app/Dockerfile

FROM python:3.9-slim

WORKDIR /app

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*


COPY ./requirements.txt .
RUN pip3 install -r ./requirements.txt

EXPOSE 8501
COPY ./elastic_gpt.py .
COPY ./config.yaml .

#HEALTHCHECK CMD curl --fail http://localhost:8501/_stcore/health

ENTRYPOINT ["streamlit", "run", "elastic_gpt.py", "--server.port=8501", "--server.address=0.0.0.0"]
