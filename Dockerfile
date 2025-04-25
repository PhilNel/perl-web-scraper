FROM amazonlinux:2023

# Install Perl and build tools
RUN yum update -y && \
    yum install -y --allowerasing perl gcc make tar gzip curl expat-devel libxml2 libxml2-devel && \
    curl -L https://cpanmin.us | perl - App::cpanminus && \
    yum clean all

# Set up local::lib environment so dependencies go into ./local
ENV PERL_CPANM_OPT="--local-lib=local"
ENV PERL5LIB=/var/task/local/lib/perl5:/var/task/lib
ENV PATH=/var/task/local/bin:$PATH

WORKDIR /var/task

# Copy only dependency file first to leverage Docker layer caching
COPY cpanfile ./

# Install dependencies
RUN cpanm --installdeps --notest --local-lib=./local .

# Copy the rest of the project
COPY . .

# Lambda runs this by default
CMD [ "perl", "main.pl" ]
