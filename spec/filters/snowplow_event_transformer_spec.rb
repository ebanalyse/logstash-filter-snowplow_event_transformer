# encoding: utf-8
require 'spec_helper'
require "logstash/filters/snowplow_event_transformer"

describe LogStash::Filters::SnowplowEventTransformer do
  describe "Set to Hello World" do
    let(:config) do <<-CONFIG
      filter {
        snowplow_event_transformer {
          message => "Hello World"
        }
      }
    CONFIG
    end

    sample("message" => "some text") do
      expect(subject.get("message")).to eq('Hello World')
    end
  end
end
