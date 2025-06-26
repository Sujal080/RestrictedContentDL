FROM python:3.11-slim

# Install OS dependencies
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    git build-essential linux-headers-amd64 tzdata && \
    rm -rf /var/lib/apt/lists/*

# Set timezone
ENV TZ=Asia/Dhaka

# Upgrade pip + install wheel
RUN pip install --no-cache-dir -U pip wheel==0.45.1

# Set working directory
WORKDIR /app

# Copy and install Python dependencies
COPY requirements.txt /app
RUN pip install -U -r requirements.txt

# Copy source code
COPY . /app

# Expose Flask port (optional but recommended)
EXPOSE 8080

# Start bot with keep_alive
CMD ["python3", "main.py"]
