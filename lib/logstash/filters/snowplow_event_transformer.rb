# encoding: utf-8
require "java"

require 'jar_dependencies'
require_jar('com.snowplowanalytics', 'snowplow-scala-analytics-sdk_2.13', '2.1.0')
require_jar('org.scala-lang', 'scala-library', '2.13.2')
require_jar('com.snowplowanalytics', 'iglu-core-circe_2.13', '1.0.0')
require_jar('com.snowplowanalytics', 'iglu-core_2.13', '1.0.0')
require_jar('io.circe', 'circe-core_2.13', '0.13.0')
require_jar('io.circe', 'circe-numbers_2.13', '0.13.0')
require_jar('org.typelevel', 'cats-core_2.13', '2.1.1')
require_jar('org.typelevel', 'cats-macros_2.13', '2.1.1')
require_jar('org.typelevel', 'cats-kernel_2.13', '2.1.1')
require_jar('io.circe', 'circe-parser_2.13', '0.13.0')
require_jar('io.circe', 'circe-jawn_2.13', '0.13.0')
require_jar('io.circe', 'circe-generic_2.13', '0.13.0')
require_jar('com.chuusai', 'shapeless_2.13', '2.3.3')

require "logstash/filters/base"
require "logstash/namespace"

# This example filter will replace the contents of the default
# message field with whatever you specify in the configuration.
#
# It is only intended to be used as an example.
class LogStash::Filters::SnowplowEventTransformer < LogStash::Filters::Base
  java_import "com.snowplowanalytics.snowplow.analytics.scalasdk.Event"

  # Setting the config_name here is required. This is how you
  # configure this filter from your Logstash config.
  #
  # filter {
  #   example {
  #     message => "My message..."
  #   }
  # }
  #
  config_name "snowplow_event_transformer"

  # Replace the message with this value.
  config :message, :validate => :string, :default => "Hello World!"


  public
  def register
    # Add instance variables
  end # def register

  public
  def filter(event)
    # Replace the event message with our message as configured in the
    # config file.

    snowplow_event = Event.parse(event.get("message"))

    if snowplow_event.is_valid
      json = snowplow_event.get_or_else('').to_json(true).no_spaces
      event.set("message", json)

      @logger.debug? && @logger.debug("Message is now: #{event.get("message")}")
      filter_matched(event)
    end
  end # def filter
end # class LogStash::Filters::Example
