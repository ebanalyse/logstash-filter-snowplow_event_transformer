FROM docker.elastic.co/logstash/logstash:7.10.2

WORKDIR /usr/share/logstash/plugins/ekstrabladet/snowplow_event_transformer

COPY . .

WORKDIR /usr/share/logstash

RUN echo 'gem "logstash-filter-snowplow_event_transformer", :path => "./plugins/ekstrabladet/snowplow_event_transformer"' >> Gemfile

RUN bin/logstash-plugin install --no-verify
