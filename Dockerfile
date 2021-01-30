FROM docker.elastic.co/logstash/logstash:7.10.2

WORKDIR /usr/share/logstash/plugins/ekstrabladet/snowplow_event_transformer

COPY . .

WORKDIR /usr/share/logstash

RUN echo 'gem "logstash-filter-snowplow_event_transformer", :path => "./plugins/ekstrabladet/snowplow_event_transformer"' >> Gemfile
RUN echo 'config.support_escapes: true' >> config/logstash.yml

RUN bin/logstash-plugin install --no-verify

COPY _pipeline/pipeline.conf pipeline/pipeline.conf

CMD [ "logstash", "-f", "pipeline/pipeline.conf" ]
