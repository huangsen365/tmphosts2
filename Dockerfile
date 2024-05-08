# Use the official Nginx Alpine image as a base
FROM nginx:alpine

# Install dnsmasq
RUN apk add --no-cache dnsmasq

# Configure dnsmasq to use Cloudflare's DNS and disable IPv6 resolution
RUN echo "server=1.1.1.1" > /etc/dnsmasq.conf
RUN echo "listen-address=127.0.0.1" >> /etc/dnsmasq.conf
RUN echo "no-resolv" >> /etc/dnsmasq.conf
#RUN echo "no-aaaa" >> /etc/dnsmasq.conf  # Correct option to block IPv6 addresses

# Remove the default Nginx configuration
RUN rm /etc/nginx/conf.d/default.conf

# Copy the custom Nginx configuration file
COPY tmphosts.conf /etc/nginx/nginx.conf

# Disable IPv6 at the OS level
RUN echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
RUN echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf
RUN echo "net.ipv6.conf.lo.disable_ipv6 = 1" >> /etc/sysctl.conf

# Expose ports for HTTP and HTTPS
EXPOSE 80 443

# Start dnsmasq and nginx
CMD ["sh", "-c", "dnsmasq && nginx -g 'daemon off;'"]

