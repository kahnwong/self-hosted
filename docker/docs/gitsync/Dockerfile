FROM alpine:3.13

RUN apk add --no-cache git bash openssh

WORKDIR /home/git

COPY git-sync.sh /home/git/git-sync.sh
RUN chmod +x /home/git/git-sync.sh

CMD ["/home/git/git-sync.sh"]