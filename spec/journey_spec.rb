require 'journey.rb'

describe Journey do
let(:entry_station) { double "entry_station" }
let(:exit_station) { double "exit_station" }
subject { Journey.new(entry_station, exit_station)}
  context '#on_journey?' do
    it "returns nil by default" do
      expect(subject.on_journey?).to eq(nil)
    end
  end

  context '#start_journey' do
    it "sets status to true when journey starts" do
      subject.start_journey
      expect(subject.on_journey?).to eq(true)
    end
  end

  context '#end_journey' do
    it "sets status to false when journey ends" do
      subject.start_journey
      subject.end_journey
      expect(subject.on_journey?).to eq(false)
    end

    it "charges minimum fare for journey" do
      expect(subject.fare).to eq(1)
    end

    it "charges penalty fare for journey end without start" do
      subject.entry_station = nil
      subject.exit_station != nil
      expect(subject.fare).to eq(6)
    end
  end
end
