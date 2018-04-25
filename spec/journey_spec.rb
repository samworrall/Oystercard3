require 'journey.rb'

describe Journey do

  context '#complete?' do
    it "returns nil by default" do
      expect(subject.complete?).to eq(nil)
    end
  end

  context '#start_journey' do
    it "sets status to false when journey starts" do
      subject.start_journey
      expect(subject.complete?).to eq(false)
    end
  end

  context '#end_journey' do
    it "sets status to true when journey ends" do
      subject.start_journey
      subject.end_journey
      expect(subject.complete?).to eq(true)
    end
  end
end
