FROM ubuntu

WORKDIR /app

COPY src .

RUN apt-get update && apt-get install --no-install-recommends --yes python3

RUN python3 -m pip install update 
RUN python3 -m pip install -r requirements.txt

CMD ["python", "test.py"]