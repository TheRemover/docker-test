FROM ubuntu

WORKDIR /app

COPY src .

RUN apt-get update && apt-get install --no-install-recommends --yes python3

RUN pip install -r requirements.txt

CMD ["python", "test.py"]