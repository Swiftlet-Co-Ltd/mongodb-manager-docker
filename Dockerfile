FROM mongo:4.2.22 AS downloader
RUN apt update && apt install curl unzip -y

# Download AWS CLI and extract file
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip

FROM mongo:4.2.22
WORKDIR /root

COPY --from=downloader ./aws ./aws
RUN ./aws/install

COPY backup /usr/bin/
RUN chmod +x /usr/bin/backup

CMD ["backup"]