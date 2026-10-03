FROM python:3.13-slim

WORKDIR /app

COPY . .

RUN apt-get update && apt-get install -y \
	build-essential \
	curl \
	git \
	&& rm -rf /var/lib/apt/lists/*

ENV PIP_EXTRA_INDEX_URL=htttps://www.piwheels.org/simple

RUN pip3 install streamlit --prefer-binary

EXPOSE 8501

HEALTHCHECK CMD curl --fail http://localhost:8501/_stcore/health

ENTRYPOINT ["streamlit", "run", "Tracker.py", "--server.port=8501", "--server.address=0.0.0.0"]