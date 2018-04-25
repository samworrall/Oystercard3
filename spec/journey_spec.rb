require 'journey.rb'

describe Journey do

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
  end
end
