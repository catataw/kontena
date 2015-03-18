require_relative '../../spec_helper'

describe Kontena::WebsocketClient do

  let(:subject) { described_class.new('', '')}

  describe '#on_message' do

    it 'calls subscribers when response message' do
      subscriber = spy
      expect(subscriber).to receive(:on_message).once
      subject.subscribe('test') {|msg|
        subscriber.on_message(msg)
      }
      event = double(:event, data: MessagePack.dump([1, 'test', nil, 'daa']).bytes)
      subject.on_message(double.as_null_object, event)
    end
  end
end