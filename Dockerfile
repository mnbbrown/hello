FROM tianon/true
ADD build/hello.linux /

ENV PORT 8080
EXPOSE 8080
CMD ["/hello.linux"]
