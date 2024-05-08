# 20240509
```
cd tmphosts2
docker build -t nginx-dnsmasq .
docker stop tmphosts && docker rm tmphosts
docker run -d --name tmphosts -p 80:80 -p 443:443 --restart always nginx-dnsmasq
```
